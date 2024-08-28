cmake_minimum_required(VERSION 3.14)

project(parquet_write_threaded LANGUAGES CXX)

set(CMAKE_BUILD_TYPE Release)

find_package(Arrow)
find_package(Parquet)

add_executable(parquet_write_threaded parquet_write_threaded.cc)
target_link_libraries(parquet_write_threaded
                      PRIVATE
                      arrow_shared
                      parquet_shared)
