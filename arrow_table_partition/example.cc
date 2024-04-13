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

/// \brief Process a single partition slice from our larger Table
//
// At this stage, our slice looks like the below, with the homeworld column
// only having a single value and each list column only have a single element.
//
// homeworld: string
// species_list: list<item: string>
//   child 0, item: string
// name_list: list<item: string>
//   child 0, item: string
// ----
// homeworld:
//   [
//     [
//       "Tatooine" <-- always a single value
//     ]
//   ]
// species_list:
//   [
//     [
//       [
//         "Human",
//         "Droid",
//         etc...
//       ]
//     ]
//   ]
// name_list:
//   [
//     [
//       [
//         "Luke Skywalker",
//         "C-3PO",
//         etc...
//       ]
//     ]
//   ]
arrow::Result<std::shared_ptr<arrow::Table>>
ProcessTableSlice(std::shared_ptr<arrow::Table> input) {
  // These next two statements are a pretty useful trick and we use it to
  // essentially explode a single value into as many as we need.
  //
  // Since homeworld column is only a single value, we need to replicate it
  // enough times so it has the same number of values as the other columns. We
  // could do this manually by building an Array but we can also take advantage
  // of the fact that the other columns are lists with only a single child so
  // all values are at offset zero. So calling list_parent_indices on a column
  // like name_list returns the correct number of zeroes and we can then call
  // take on those indices to get our replicated values.
  ARROW_ASSIGN_OR_RAISE(
      auto indices,
      arrow::compute::CallFunction("list_parent_indices",
                                   {input->GetColumnByName("name_list")}));
  ARROW_ASSIGN_OR_RAISE(
      auto homeworld,
      arrow::compute::Take(input->GetColumnByName("homeworld"), indices));

  // For the other columns we can just flatten them
  ARROW_ASSIGN_OR_RAISE(
      auto species,
      arrow::compute::CallFunction("list_flatten",
                                   {input->GetColumnByName("species_list")}));
  ARROW_ASSIGN_OR_RAISE(
      auto names, arrow::compute::CallFunction(
                      "list_flatten", {input->GetColumnByName("name_list")}));

  // Create our schema
  auto schema = arrow::schema({
      arrow::field("homeworld", arrow::utf8()),
      arrow::field("species", arrow::utf8()),
      arrow::field("name", arrow::utf8()),
  });

  return arrow::Table::Make(std::move(schema),
                            {homeworld.chunked_array(), species.chunked_array(),
                             names.chunked_array()});
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
  ARROW_ASSIGN_OR_RAISE(auto partitioned_table,
                        arrow::acero::DeclarationToTable(std::move(plan)));

  // Convert the result into a map of partition<->Table
  std::unordered_map<std::string, std::shared_ptr<arrow::Table>> tables;
  auto n_partitions = partitioned_table->GetColumnByName("homeworld")->length();
  tables.reserve(n_partitions);

  for (int i = 0; i < n_partitions; i++) {
    // Get the key for this partition from the partitioned_table
    ARROW_ASSIGN_OR_RAISE(auto key,
                          partitioned_table->GetColumnByName("homeworld")
                              ->chunk(0)
                              ->GetScalar(i));

    // Flatten the slice and handle the key column
    ARROW_ASSIGN_OR_RAISE(auto flat, ProcessTableSlice(std::move(
                                         partitioned_table->Slice(i, 1))));

    tables.insert({key->ToString(), flat});
  }

  // Print out our results
  for (auto iter = tables.begin(); iter != tables.end(); ++iter) {
    std::cout << iter->first << std::endl;
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
