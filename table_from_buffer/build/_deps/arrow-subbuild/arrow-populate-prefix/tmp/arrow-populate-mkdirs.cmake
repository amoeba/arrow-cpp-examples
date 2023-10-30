# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-src"
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-build"
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix"
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix/tmp"
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix/src/arrow-populate-stamp"
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix/src"
  "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix/src/arrow-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix/src/arrow-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/bryce/src/arrow-cpp-examples/table_from_buffer/build/_deps/arrow-subbuild/arrow-populate-prefix/src/arrow-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
