#include <cstddef>
#include <iostream>
#include <memory>
#include <vector>

#include "arrow/api.h"
#include "arrow/chunked_array.h"
#include "arrow/dataset/partition.h"
#include "arrow/io/file.h"
#include "arrow/record_batch.h"
#include "arrow/result.h"
#include "arrow/status.h"
#include "arrow/type.h"
#include "arrow/type_fwd.h"
#include "parquet/arrow/reader.h"


arrow::Status RunMain(std::string path) {
  arrow::MemoryPool *pool = arrow::default_memory_pool();

  // Read our Parquet file in as a Table
  std::shared_ptr<arrow::io::RandomAccessFile> input;
  ARROW_ASSIGN_OR_RAISE(input, arrow::io::ReadableFile::Open(path));

  std::unique_ptr<parquet::arrow::FileReader> arrow_reader;
  ARROW_RETURN_NOT_OK(parquet::arrow::OpenFile(input, pool, &arrow_reader));

  std::shared_ptr<arrow::RecordBatchReader> rbr;
  ARROW_RETURN_NOT_OK(arrow_reader->GetRecordBatchReader(&rbr));

  // Set up partitioning so we can partition by the species column
  std::shared_ptr<arrow::dataset::Partitioning> partitioning = std::make_shared<arrow::dataset::DirectoryPartitioning>(
      arrow::schema({field("species", arrow::utf8())}));

  // Consume all batches from the RecordBatchReader
  while(true) {
    ARROW_ASSIGN_OR_RAISE(auto batch, rbr->Next());

    if (batch == nullptr) {
      break;
    }

  // For each RecordBatch we get, partition it and do something with each group
    ARROW_ASSIGN_OR_RAISE(auto groups, partitioning->Partition(batch));

    for (std::size_t index = 0; index < groups.batches.size(); index++) {
      // Process each group. In this case, we just print it to stdout
      std::cout << groups.expressions.at(index).ToString() << std::endl;
      std::cout << groups.batches.at(index)->ToString() << std::endl;
    }
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
