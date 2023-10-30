#include <iostream>

#include "arrow/memory_pool.h"
#include "arrow/io/file.h"
#include "arrow/io/memory.h"
#include "arrow/io/buffered.h"
#include "arrow/dataset/file_ipc.h"
#include "arrow/table.h"
#include "arrow/ipc/writer.h"
#include "arrow/ipc/reader.h"
#include "arrow/io/stdio.h"

#include <arrow/api.h>
#include <arrow/result.h>
#include <arrow/status.h>

arrow::Status FillArray(std::shared_ptr<arrow::Array> &arr) {
  arrow::NumericBuilder<arrow::Int64Type> int64_builder;

  auto resize_status = int64_builder.Resize(5);

  if (!resize_status.ok()) {
    return resize_status;
  }

  std::vector<int64_t> int64_values = {1, 2, 3, 4, 5};
  auto append_status = int64_builder.AppendValues(int64_values);

  if (!append_status.ok()) {
    return append_status;
  }

  return int64_builder.Finish(&arr);
}

arrow::Status RunMain() {
  // Make a Schema for our Table
  auto schema = arrow::schema({field("a", arrow::int64())});

  // Make a test Array to store in our Table
  std::shared_ptr<arrow::Array> array_a;

  auto fill_array_status = FillArray(array_a);

  if (!fill_array_status.ok()) {
    return fill_array_status;
  }

  // Make the Table
  auto tbl = arrow::Table::Make(schema, {array_a}, 5);


  auto bos_result = arrow::io::BufferedOutputStream::Create(1024, arrow::MemoryPool::CreateDefault());

  if (!bos_result.ok()) {
    return bos_result.status();
  }

  auto make_result = arrow::ipc::MakeStreamWriter(bos_result->get(), tbl->schema());

  if (!make_result.ok()) {
    return make_result.status();
  }



  return arrow::Status::OK();
}

int main() {
  arrow::Status st = RunMain();
  if (!st.ok()) {
    std::cerr << st << std::endl;
    return 1;
  }
  return 0;
}
