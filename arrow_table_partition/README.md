# arrow_table_partition

Example of partitioning a Table by unique values in a column and slicing that result into one table per partition.

This is basically the C++ equivalent of this type of PyArrow code:

```python
import pyarrow as pa

table = pa.table([
    pa.array(["a", "a", "b", "b", "c"]),
    pa.array([1, 2, 3, 4, 5]),
], names=["keys", "values"])

out = table.group_by("keys").aggregate([
    ("values", "hash_list")
])
out
```

This prints:

```sh
pyarrow.Table
keys: string
values_list: list<item: int64>
  child 0, item: int64
----
keys: [["a","b","c"]]
values_list: [[[1,2],[3,4],[5]]]
```

And then slicing the result to get a single Table as a partition:

```python
out.slice(0, 1)
```

Which prints:

```sh
pyarrow.Table
keys: string
values_list: list<item: int64>
  child 0, item: int64
----
keys: [["a"]]
values_list: [[[1,2]]]
```

## Pre-requisites

- Modern C++ compiler toolchain
- CMake
- Likely a few system libraries, depending on your system
- starwars.parquet from dplyr, see [starwars](https://dplyr.tidyverse.org/reference/starwars.html)
  - To get a copy, run this R code:

      ```r
      library(arrow)
      library(dplyr)

      write_parquet(arrow_table(starwars), "starwars.parquet")
      ```

## Building

```sh
mkdir build
cd build
cmake ..
make
```

## Running

```sh
./example $SOME_PARQUET_FILE
```

## Example Output

This uses the `starwars.parquet` file listed in pre-requisites.

```sh
$ ./example starwars.parquet
<<<...truncated...>>>
homeworld: string
species_list: list<item: string>
  child 0, item: string
name_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Tatooine"
    ]
  ]
species_list:
  [
    [
      [
        "Human",
        "Droid",
        "Human",
        "Human",
        "Human",
        "Droid",
        "Human",
        "Human",
        "Human",
        "Human"
      ]
    ]
  ]
name_list:
  [
    [
      [
        "Luke Skywalker",
        "C-3PO",
        "Darth Vader",
        "Owen Lars",
        "Beru Whitesun Lars",
        "R5-D4",
        "Biggs Darklighter",
        "Anakin Skywalker",
        "Shmi Skywalker",
        "Cliegg Lars"
      ]
    ]
  ]
```
