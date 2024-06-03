#include <iostream>

#include "arrow/api.h"
#include "arrow/array/array_dict.h"
#include "arrow/record_batch.h"
#include "arrow/result.h"
#include "arrow/status.h"
#include "arrow/type.h"
#include "arrow/type_fwd.h"

arrow::Status RunMain() {
  // 1. Create a RecordBatch with a column of integer indices
  arrow::Int32Builder builder;

  ARROW_RETURN_NOT_OK(builder.Append(0));
  ARROW_RETURN_NOT_OK(builder.Append(1));
  ARROW_RETURN_NOT_OK(builder.Append(1));
  ARROW_RETURN_NOT_OK(builder.Append(1));
  ARROW_RETURN_NOT_OK(builder.Append(1));
  ARROW_RETURN_NOT_OK(builder.Append(1));
  ARROW_RETURN_NOT_OK(builder.Append(2));
  ARROW_RETURN_NOT_OK(builder.Append(2));
  ARROW_RETURN_NOT_OK(builder.Append(2));
  ARROW_RETURN_NOT_OK(builder.Append(3));
  ARROW_RETURN_NOT_OK(builder.Append(4));
  ARROW_RETURN_NOT_OK(builder.Append(4));
  ARROW_RETURN_NOT_OK(builder.Append(4));
  ARROW_RETURN_NOT_OK(builder.Append(4));
  ARROW_RETURN_NOT_OK(builder.Append(4));
  ARROW_RETURN_NOT_OK(builder.Append(5));
  ARROW_RETURN_NOT_OK(builder.Append(5));
  ARROW_RETURN_NOT_OK(builder.Append(5));
  ARROW_ASSIGN_OR_RAISE(auto indices_arr, builder.Finish());

  std::shared_ptr<arrow::Schema> schema =
      arrow::schema({arrow::field("timestamp_indices", arrow::int32())});
  auto batch = arrow::RecordBatch::Make(schema, 18, {indices_arr});

  // 2. Create an array of our values, which we'll use to create a DictionaryArray next
  arrow::TimestampBuilder ts_builder(arrow::timestamp(arrow::TimeUnit::NANO),
                                     arrow::default_memory_pool());
  ARROW_RETURN_NOT_OK(ts_builder.Append(0));
  ARROW_RETURN_NOT_OK(ts_builder.Append(1));
  ARROW_RETURN_NOT_OK(ts_builder.Append(2));
  ARROW_RETURN_NOT_OK(ts_builder.Append(3));
  ARROW_RETURN_NOT_OK(ts_builder.Append(4));
  ARROW_RETURN_NOT_OK(ts_builder.Append(5));
  ARROW_ASSIGN_OR_RAISE(auto dictionary_arr, ts_builder.Finish());

  // 3. Create a DictionaryArray from the indices and dictionary we just made
  ARROW_ASSIGN_OR_RAISE(
      auto new_dict_arr,
      arrow::DictionaryArray::FromArrays(
          dictionary(arrow::int32(), arrow::timestamp(arrow::TimeUnit::NANO)),
          batch->GetColumnByName("timestamp_indices"), dictionary_arr));

  // 4. Add the new DictionaryArray to our RecordBatch
  ARROW_ASSIGN_OR_RAISE(auto new_batch,
                        batch->AddColumn(1, "timestamps", new_dict_arr));
  std::cout << new_batch->ToString() << std::endl;

  return arrow::Status::OK();
}

int main(int argc, char **argv) {
  auto result = RunMain();

  if (!result.ok()) {
    std::cout << "RunMain() failed with error message: " << result.message()
              << std::endl;

    return -1;
  }

  return 0;
}
