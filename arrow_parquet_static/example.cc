#include <iostream>

#include "arrow/io/api.h"
#include <arrow/api.h>
#include <parquet/arrow/reader.h>

arrow::Status RunMain(std::string path) {
  arrow::MemoryPool *pool = arrow::default_memory_pool();
  std::shared_ptr<arrow::io::RandomAccessFile> input;
  ARROW_ASSIGN_OR_RAISE(input, arrow::io::ReadableFile::Open(path));

  std::unique_ptr<parquet::arrow::FileReader> arrow_reader;
  ARROW_RETURN_NOT_OK(parquet::arrow::OpenFile(input, pool, &arrow_reader));

  std::shared_ptr<arrow::Table> table;
  ARROW_RETURN_NOT_OK(arrow_reader->ReadTable(&table));

  std::cout << table->ToString() << std::endl;

  return arrow::Status::OK();
}

int main(int argc, char **argv) {
  if (argc < 1) {
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
