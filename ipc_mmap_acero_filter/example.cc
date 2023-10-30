#include <iostream>
#include <memory>
#include <string>
#include <vector>

#include "arrow/acero/exec_plan.h"
#include "arrow/acero/options.h"
#include "arrow/acero/util.h"
#include "arrow/builder.h"
#include "arrow/compute/api_scalar.h"
#include "arrow/compute/api_vector.h"
#include "arrow/compute/expression.h"
#include "arrow/compute/ordering.h"
#include "arrow/datum.h"
#include "arrow/io/file.h"
#include "arrow/ipc/api.h"
#include "arrow/ipc/reader.h"
#include "arrow/record_batch.h"
#include "arrow/result.h"
#include "arrow/status.h"
#include "arrow/table.h"
#include "arrow/type_fwd.h"

arrow::Result<std::shared_ptr<arrow::ipc::RecordBatchFileReader>>
OpenIPCFileMMapped(const std::string path) {
  ARROW_ASSIGN_OR_RAISE(auto input, arrow::io::MemoryMappedFile::Open(
                                        path, arrow::io::FileMode::type::READ));

  auto read_options = arrow::ipc::IpcReadOptions::Defaults();
  auto reader = arrow::ipc::RecordBatchFileReader::Open(input, read_options);

  return reader;
}

arrow::Result<std::shared_ptr<arrow::RecordBatchReader>>
FileToRecordBatchReader(
    const std::shared_ptr<arrow::ipc::RecordBatchFileReader> file_reader) {
  ARROW_ASSIGN_OR_RAISE(auto tbl, file_reader->ToTable());

  std::shared_ptr<arrow::RecordBatchReader> reader =
      std::make_shared<arrow::TableBatchReader>(tbl);

  return reader;
}

arrow::Status RunMain(const std::string path, const std::string col_name) {
  // Step 1: Open the IPC file as a MemoryMapped file
  ARROW_ASSIGN_OR_RAISE(auto file_reader, OpenIPCFileMMapped(path));

  // Step 2: Convert to a RecordBatchReader so Acero can consume it
  ARROW_ASSIGN_OR_RAISE(auto reader, FileToRecordBatchReader(file_reader));

  // Step 4: Generate an Array with some values to filter with. A more realistic
  // program would bring these in from another source
  auto builder = arrow::Int8Builder();
  ARROW_RETURN_NOT_OK(builder.Append(1));
  ARROW_RETURN_NOT_OK(builder.Append(3));
  ARROW_RETURN_NOT_OK(builder.Append(7));
  ARROW_ASSIGN_OR_RAISE(auto values, builder.Finish());

  // Step 4: Create an execute an ExecPlan that filters the RecordBatches
  arrow::acero::Declaration decl = arrow::acero::Declaration::Sequence({
      {"record_batch_reader_source",
       arrow::acero::RecordBatchReaderSourceNodeOptions({reader})},
      {"filter", arrow::acero::FilterNodeOptions{call(
                     "is_in", {arrow::compute::field_ref(col_name)},
                     arrow::compute::SetLookupOptions{values})}},
  });

  auto result = arrow::acero::DeclarationToExecBatches(decl);

  ARROW_ASSIGN_OR_RAISE(auto tbl, arrow::acero::TableFromExecBatches(
                                      reader->schema(), result->batches));

  ARROW_ASSIGN_OR_RAISE(auto batch, tbl->CombineChunksToBatch());
  auto arr = batch->column(0);

  ARROW_ASSIGN_OR_RAISE(
      auto indices, arrow::compute::CallFunction("array_sort_indices", {arr}));
  ARROW_ASSIGN_OR_RAISE(
      auto new_array,
      arrow::compute::Take(arr, indices, arrow::compute::TakeOptions{}));

  std::cout << "Successfully filtered to " << tbl->num_rows() << " rows."
            << std::endl;

  return arrow::Status::OK();
}

int main(int argc, char **argv) {
  if (argc < 2) {
    std::cout << "Usage: ./example path_to_ipc_file.arrow" << std::endl;

    return -1;
  }

  auto path = argv[1];
  std::string col_name = "i"; // Hardcoded for sake of the example

  std::cout << "Filtering " << path << std::endl;

  auto result = RunMain(path, col_name);

  if (!result.ok()) {
    std::cout << "RunMain() failed with error message: " << result.message()
              << std::endl;

    return -1;
  }

  return 0;
}
