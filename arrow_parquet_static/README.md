# arrow_parquet_static

Example of using Parquet C++ linking to the _static_ Arrow libraries.

## Running

```
mkdir build
cd build
cmake .. -GNinja
ninja
./example <path_to_some_parquet_file.parqeut>
```

A string representation of the Parquet file as an Arrow Table should be printed.
