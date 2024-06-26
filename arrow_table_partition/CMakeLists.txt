cmake_minimum_required(VERSION 3.14)

project(example LANGUAGES CXX)

set(CMAKE_BUILD_TYPE Debug)

set(ARROW_BUILD_SHARED True)
set(ARROW_BUILD_STATIC True)

set(ARROW_DEPENDENCY_SOURCE "SYSTEM")
set(ARROW_SIMD_LEVEL NONE) # macOS-specific workaround

# Turn on Arrow features here (and add them to target_link_libraries when
# appropriate)
set(ARROW_ACERO ON)
set(ARROW_PARQUET ON)
set(ARROW_IPC ON)
set(ARROW_DATASET ON)
set(ARROW_FILESYSTEM ON)
set(ARROW_COMPUTE ON)

# Get Arrow
include(FetchContent)

FetchContent_Declare(Arrow
  GIT_REPOSITORY https://github.com/apache/arrow.git
  GIT_TAG main
  GIT_SHALLOW TRUE SOURCE_SUBDIR cpp
  OVERRIDE_FIND_PACKAGE
)

FetchContent_MakeAvailable(Arrow)

# HACK: Stolen from
# https://github.com/rapidsai/cudf/blob/branch-23.08/cpp/cmake/thirdparty/get_arrow.cmake#LL236C1-L238C8
file(INSTALL "${arrow_BINARY_DIR}/src/arrow/util/config.h"
  DESTINATION "${arrow_SOURCE_DIR}/cpp/src/arrow/util")

# NOTE: I had to add this to make headers available which I find weird
target_include_directories(
  arrow_static
  INTERFACE "$<BUILD_INTERFACE:${arrow_SOURCE_DIR}/cpp/src>"
)

add_executable(example example.cc)
target_link_libraries(example
  PRIVATE
  arrow_shared
  arrow_acero_shared
  parquet_static)

add_executable(example_batch_partitioning example_batch_partitioning.cc)
target_link_libraries(example_batch_partitioning
  PRIVATE
  arrow_shared
  arrow_dataset_shared
  arrow_acero_shared
  parquet_static)
