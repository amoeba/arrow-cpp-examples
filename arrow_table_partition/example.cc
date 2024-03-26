#include <iostream>

#include "arrow/acero/exec_plan.h"
#include "arrow/acero/options.h"
#include "arrow/api.h"
#include "arrow/compute/api.h"
#include "arrow/io/api.h"
#include "parquet/arrow/reader.h"

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
  auto table_source_options = arrow::acero::TableSourceNodeOptions{table};
  auto aggregate_options = arrow::acero::AggregateNodeOptions{
      /*aggregates=*/{{"hash_list", nullptr, "homeworld", "hash_list"}}};

  arrow::acero::Declaration plan = arrow::acero::Declaration::Sequence(
      {{"source", std::move(table_source_options)},
       {"aggregate", std::move(aggregate_options)}});

  // Collect the result
  std::shared_ptr<arrow::Table> response_table;
  ARROW_ASSIGN_OR_RAISE(response_table,
                        arrow::acero::DeclarationToTable(std::move(plan)));

  std::cout << response_table->ToString() << std::endl;

  return arrow::Status::OK();
}

int main(int argc, char **argv) {
  arrow::Status st = RunMain("/Users/bryce/Data/starwars.parquet");

  if (!st.ok()) {
    std::cerr << st << std::endl;
    return 1;
  }

  return 0;
}
