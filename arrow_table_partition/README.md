# arrow_table_partition

Example of partitioning a Table by unique values in a column and slicing that result into one table per partition.

Also includes an example of partitioning a Partitioning from the Datasets API, see ./example_batch_partitioning.cc.
The remainder of this README is for the original example, ./example.cc.

## Summary

The core of the logic in the C++ code can be expressed with PyArrow as:

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
single = out.slice(0, 1)
single
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

The example C++ code goes one step further and flattens the sliced Table.

```python
indices = pc.list_parent_indices(single.column("values_list"))
keys = pc.take(single.column("keys"), indices)
values = pc.list_flatten(single.column("values_list"))

flattened = pa.Table.from_arrays([keys, values], names=["keys", "values"])
flattened.to_pandas()
###   keys  values
### 0    a       1
### 1    a       2
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
Tatooine
homeworld: string
species: string
name: string
----
homeworld:
  [
    [
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine",
      "Tatooine"
    ]
  ]
species:
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
name:
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
```
