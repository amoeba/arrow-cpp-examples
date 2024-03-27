#include <iostream>
#include <memory>
#include <unordered_map>
#include <vector>

#include "arrow/acero/exec_plan.h"
#include "arrow/acero/options.h"
#include "arrow/api.h"
#include "arrow/array/array_base.h"
#include "arrow/array/builder_binary.h"
#include "arrow/array/concatenate.h"
#include "arrow/chunked_array.h"
#include "arrow/compute/api.h"
#include "arrow/io/api.h"
#include "arrow/result.h"
#include "arrow/status.h"
#include "arrow/type.h"
#include "arrow/type_fwd.h"
#include "parquet/arrow/reader.h"

arrow::Result<std::shared_ptr<arrow::Array>>
ConcatenateChunkedListArray(std::shared_ptr<arrow::ChunkedArray> chunked) {
  arrow::ArrayVector vec;

  for (int i = 0; i < chunked->num_chunks(); i++) {
    ARROW_ASSIGN_OR_RAISE(
        auto flattened,
        arrow::compute::CallFunction("list_flatten", {chunked->chunk(i)}));
    vec.push_back(flattened.make_array());
  }

  ARROW_ASSIGN_OR_RAISE(auto result, arrow::Concatenate(vec));

  return result;
}

arrow::Result<std::shared_ptr<arrow::Table>>
FlattenPartitionedTable(std::shared_ptr<arrow::Table> input) {
  std::vector<std::shared_ptr<arrow::Array>> arrays;
  arrays.reserve(input->num_columns());

  // Handle rest, assuming index 1 and higher are the rest
  for (int i = 1; i < input->num_columns(); i++) {
    ARROW_ASSIGN_OR_RAISE(
        auto array, ConcatenateChunkedListArray(std::move(input->column(i))));

    std::cout << array->ToString() << std::endl;

    arrays.push_back(std::move(array));
  }

  // Handle first col, we need to duplicate its one value nrows times
  auto nrows = arrays[0]->length();
  ARROW_ASSIGN_OR_RAISE(auto single,
                        input->GetColumnByName("homeworld")->GetScalar(0));

  arrow::StringBuilder builder;
  for (int i = 0; i < nrows; i++) {
    ARROW_RETURN_NOT_OK(builder.AppendScalar(*single));
  }
  ARROW_ASSIGN_OR_RAISE(auto final, builder.Finish());

  arrays.push_back(final);

  auto new_schema = arrow::schema({arrow::field("species", arrow::utf8()),
                                   arrow::field("name", arrow::utf8()),
                                   arrow::field("homeworld", arrow::utf8())});

  auto x = arrow::Table::Make(std::move(new_schema), std::move(arrays));

  if (x->ValidateFull().ok()) {
    std::cout << "Valid!" << std::endl;
  } else {
    std::cout << "BOOM!" << x->ValidateFull().message() << std::endl;
  }
  return x;
}

arrow::Status RunMain(std::string path) {
  arrow::MemoryPool *pool = arrow::default_memory_pool();

  // Read our Parquet file in as a Table
  std::shared_ptr<arrow::io::RandomAccessFile> input;
  ARROW_ASSIGN_OR_RAISE(input, arrow::io::ReadableFile::Open(path));

  std::unique_ptr<parquet::arrow::FileReader> arrow_reader;
  ARROW_RETURN_NOT_OK(parquet::arrow::OpenFile(input, pool, &arrow_reader));

  std::shared_ptr<arrow::Table> table;
  ARROW_RETURN_NOT_OK(arrow_reader->ReadTable(&table));

  // Make our plan
  // It reads cleaner to set up options separately first, so we do that
  auto table_source_options =
      arrow::acero::TableSourceNodeOptions{std::move(table)};

  auto aggregate_options = arrow::acero::AggregateNodeOptions(
      /*aggregates=*/{{{"hash_list", nullptr, "species", "species_list"},
                       {"hash_list", nullptr, "name", "name_list"}}},
      {"homeworld"});

  // Then we create the plan
  auto plan = arrow::acero::Declaration::Sequence(
      {{"table_source", std::move(table_source_options)},
       {"aggregate", std::move(aggregate_options)}});

  // Collect the result as a Table
  std::shared_ptr<arrow::Table> partitioned_table;
  ARROW_ASSIGN_OR_RAISE(partitioned_table,
                        arrow::acero::DeclarationToTable(std::move(plan)));

  // If we want, we can split the single Table into one Table per partition by
  // taking k slices
  std::unordered_map<std::string, std::shared_ptr<arrow::Table>> tables;
  auto n_partitions = partitioned_table->GetColumnByName("homeworld")->length();
  tables.reserve(n_partitions);

  for (int i = 0; i < n_partitions; i++) {
    // Get the key for this partition from the partitioned_table
    ARROW_ASSIGN_OR_RAISE(auto key,
                          partitioned_table->GetColumnByName("homeworld")
                              ->chunk(0)
                              ->GetScalar(i));
    ARROW_ASSIGN_OR_RAISE(auto flat, FlattenPartitionedTable(std::move(
                                         partitioned_table->Slice(i, 1))));
    tables.insert({key->ToString(), flat});
  }

  // Print out our results
  for (auto iter = tables.begin(); iter != tables.end(); ++iter) {
    std::cout << iter->second->ToString() << std::endl;
  }

  return arrow::Status::OK();
}

int main(int argc, char **argv) {
  if (argc < 2) {
    std::cout << "Must specify filename. Usage `./example my.parquet`. Exiting."
              << std::endl;

    return -1;
  }

  arrow::Status st = RunMain(argv[1]);

  if (!st.ok()) {
    std::cerr << st << std::endl;
    return 1;
  }

  return 0;
}
