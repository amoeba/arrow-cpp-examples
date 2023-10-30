# Install script for directory: /Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/arrow/acero" TYPE FILE FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/accumulation_queue.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/aggregate_node.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/api.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/asof_join_node.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/benchmark_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/bloom_filter.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/exec_plan.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/hash_join.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/hash_join_dict.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/hash_join_node.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/map_node.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/options.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/order_by_impl.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/partition_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/pch.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/query_context.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/schema_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/task_util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/test_nodes.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/tpch_node.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/type_fwd.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/util.h"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src/cpp/src/arrow/acero/visibility.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/debug/libarrow_acero.1300.0.0.dylib"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/debug/libarrow_acero.1300.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libarrow_acero.1300.0.0.dylib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libarrow_acero.1300.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/usr/bin/install_name_tool"
        -id "/usr/local/lib/libarrow_acero.1300.dylib"
        -change "@rpath/libarrow.1300.dylib" "/usr/local/lib/libarrow.1300.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/Library/Developer/CommandLineTools/usr/bin/strip" -x "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/debug/libarrow_acero.dylib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero" TYPE FILE FILES
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/acero/ArrowAceroConfig.cmake"
    "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/acero/ArrowAceroConfigVersion.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero/ArrowAceroTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero/ArrowAceroTargets.cmake"
         "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/acero/CMakeFiles/Export/d7d2c1ddcde43433b8c5420fc45422e9/ArrowAceroTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero/ArrowAceroTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero/ArrowAceroTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/acero/CMakeFiles/Export/d7d2c1ddcde43433b8c5420fc45422e9/ArrowAceroTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/ArrowAcero" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/acero/CMakeFiles/Export/d7d2c1ddcde43433b8c5420fc45422e9/ArrowAceroTargets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build/src/arrow/acero/DEBUG/arrow-acero.pc")
endif()

