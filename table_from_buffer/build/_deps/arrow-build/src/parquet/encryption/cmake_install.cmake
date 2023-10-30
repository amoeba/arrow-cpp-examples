# Install script for directory: /Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/parquet/encryption" TYPE FILE FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/crypto_factory.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/encryption.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/file_key_material_store.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/file_key_unwrapper.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/file_key_wrapper.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/file_system_key_material_store.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/key_encryption_key.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/key_material.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/key_metadata.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/key_toolkit.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/kms_client.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/kms_client_factory.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/local_wrap_kms_client.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/test_encryption_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/test_in_memory_kms.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encryption/two_level_cache_with_expiration.h"
    )
endif()

