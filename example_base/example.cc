#include <iostream>

#include "arrow/api.h"
#include "arrow/status.h"
#include "arrow/type.h"
#include "arrow/type_fwd.h"

arrow::Status RunMain() { return arrow::Status::OK(); }

int main(int argc, char **argv) {
  auto result = RunMain();

  if (!result.ok()) {
    std::cout << "RunMain() failed with error message: " << result.message()
              << std::endl;

    return -1;
  }

  return 0;
}
