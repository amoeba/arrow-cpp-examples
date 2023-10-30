# Install script for directory: /Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/debug/libparquet.1300.0.0.dylib"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/debug/libparquet.1300.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libparquet.1300.0.0.dylib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libparquet.1300.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/usr/bin/install_name_tool"
        -id "/usr/local/lib/libparquet.1300.dylib"
        -change "@rpath/libarrow.1300.dylib" "/usr/local/lib/libarrow.1300.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/Library/Developer/CommandLineTools/usr/bin/strip" -x "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/debug/libparquet.dylib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet" TYPE FILE FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/ParquetConfig.cmake"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/ParquetConfigVersion.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet/ParquetTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet/ParquetTargets.cmake"
         "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/CMakeFiles/Export/56c4c1eadc5ea6fcb65bdde4634255f9/ParquetTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet/ParquetTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet/ParquetTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/CMakeFiles/Export/56c4c1eadc5ea6fcb65bdde4634255f9/ParquetTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Parquet" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/CMakeFiles/Export/56c4c1eadc5ea6fcb65bdde4634255f9/ParquetTargets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/DEBUG/parquet.pc")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/api/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/arrow/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/encryption/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/parquet" TYPE FILE FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/benchmark_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/bloom_filter.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/bloom_filter_reader.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/column_page.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/column_reader.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/column_scanner.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/column_writer.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/encoding.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/exception.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/file_reader.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/file_writer.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/hasher.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/level_comparison.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/level_comparison_inc.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/level_conversion.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/level_conversion_inc.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/metadata.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/page_index.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/pch.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/platform.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/printer.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/properties.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/schema.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/statistics.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/stream_reader.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/stream_writer.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/test_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/type_fwd.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/types.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/windows_compatibility.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/windows_fixup.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/parquet/xxhasher.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/parquet" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/parquet/parquet_version.h")
endif()

