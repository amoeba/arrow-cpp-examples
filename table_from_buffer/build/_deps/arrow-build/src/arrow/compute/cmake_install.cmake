# Install script for directory: /Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "DEBUG")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Library/Developer/CommandLineTools/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/arrow/compute" TYPE FILE FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/api.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/api_aggregate.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/api_scalar.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/api_vector.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/cast.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/exec.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/expression.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/function.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/kernel.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/key_hash.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/key_map.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/light_array.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/ordering.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/registry.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/type_fwd.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/compute/util.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/compute/DEBUG/arrow-compute.pc")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/compute/kernels/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/compute/row/cmake_install.cmake")
endif()

