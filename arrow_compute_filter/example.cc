#include <iostream>
#include <memory>

#include "arrow/api.h"
#include "arrow/array/array_base.h"
#include "arrow/array/array_dict.h"
#include "arrow/compute/api_vector.h"
#include "arrow/compute/cast.h"
#include "arrow/compute/exec.h"
#include "arrow/compute/expression.h"
#include "arrow/record_batch.h"
#include "arrow/result.h"
#include "arrow/status.h"
#include "arrow/type.h"
#include "arrow/type_fwd.h"

arrow::Result<std::shared_ptr<arrow::Array>> MakeExampleArray() {
  arrow::Int64Builder builder;

  builder.Append(1);
  builder.Append(2);
  builder.Append(3);

  return builder.Finish();
}

std::shared_ptr<arrow::RecordBatch>
MakeExampleRecordBatch(std::shared_ptr<arrow::Schema> schema) {
  auto arr = MakeExampleArray();

  return arrow::RecordBatch::Make(schema, 3, {arr.ValueOrDie()});
}

arrow::Status RunMain() {
  const std::shared_ptr<arrow::Schema> schema =
      arrow::schema({field("nums", arrow::int64())});
  auto rb = MakeExampleRecordBatch(schema);

  // filter
  auto expr = arrow::compute::equal(arrow::compute::field_ref("nums"),
                                    arrow::compute::literal(1));
  ARROW_ASSIGN_OR_RAISE(auto bound_expr, expr.Bind(*schema))

  arrow::compute::ExecBatch exec_batch(*rb);
  ARROW_ASSIGN_OR_RAISE(auto result, arrow::compute::ExecuteScalarExpression(
                                         bound_expr, exec_batch));

  // cast
  arrow::compute::CastOptions cast_opts{};
  cast_opts.to_type = arrow::int64();
  ARROW_ASSIGN_OR_RAISE(auto cast_result,
                        arrow::compute::Cast(result, cast_opts));

  // take
  ARROW_ASSIGN_OR_RAISE(auto take_res, arrow::compute::Take(rb, cast_result));

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
