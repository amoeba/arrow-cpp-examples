# ipc_mmap_acero_filter

Example C++ code showing how to memory-map an Arrow IPC file and use Acero to
filter it.

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
5. `./example`
