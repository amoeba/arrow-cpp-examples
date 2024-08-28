#include "arrow/result.h"
#include "arrow/status.h"
#include <chrono>
#include <iostream>

#include <arrow/io/file.h>
#include <arrow/table.h>
#include <parquet/arrow/reader.h>
#include <parquet/arrow/writer.h>

arrow::Status RunMain(const std::string path, bool use_threads) {
  // Read the entire input Parquet file in as a Table
  ARROW_ASSIGN_OR_RAISE(auto input_file, arrow::io::ReadableFile::Open(path));

  std::unique_ptr<parquet::arrow::FileReader> arrow_reader;
  ARROW_RETURN_NOT_OK(parquet::arrow::OpenFile(
      input_file, arrow::default_memory_pool(), &arrow_reader));

  std::shared_ptr<::arrow::Table> table;
  ARROW_RETURN_NOT_OK(arrow_reader->ReadTable(&table));

  // Set up our properties, set_use_threads is key here
  auto props = parquet::default_writer_properties();
  auto arrow_props = parquet::ArrowWriterProperties::Builder()
                         .set_use_threads(use_threads)
                         ->build();

  // Multithreaded writes only work with the WriteRecordBatch API so we convert
  // our Table into batches
  ARROW_ASSIGN_OR_RAISE(auto batches,
                        arrow::TableBatchReader(table).ToRecordBatches());

  std::shared_ptr<arrow::io::FileOutputStream> outfile;
  ARROW_ASSIGN_OR_RAISE(outfile,
                        arrow::io::FileOutputStream::Open("out.parquet"));

  ARROW_ASSIGN_OR_RAISE(auto writer, parquet::arrow::FileWriter::Open(
                                         *table->schema().get(),
                                         arrow::default_memory_pool(), outfile,
                                         props, arrow_props));

  // We time this loop. There's only one batch but we loop just in case.
  auto time_start = std::chrono::high_resolution_clock::now();

  for (auto batch : batches) {
    ARROW_RETURN_NOT_OK(writer->WriteRecordBatch(*batch));
  }

  auto time_end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double> duration = time_end - time_start;
  std::cout << "File took " << duration.count() << "s to be written."
            << std::endl;

  return arrow::Status::OK();
}

int main(int argc, char **argv) {
  // TODO: Handle use_threads dynamically from args
  auto result = RunMain(argv[1], true);

  if (!result.ok()) {
    std::cout << "RunMain() failed with error message: " << result.message()
              << std::endl;

    return -1;
  }

  return 0;
}
