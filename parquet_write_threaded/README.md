# parquet_write_threaded

Short program to check the impact of writing Parquet files with `use_theads = true`;

## Pre-requisites

- git
- cmake
- A C++ compiler toolchain

## Building

1. `mkdir build`
2. `cd build`
3. `cmake ..`
   This fetches Arrow from GitHub so it takes a bit and produces no output
4. `cmake --build .`
5. `./example $PATH_TO_PARQUET_FILE`
