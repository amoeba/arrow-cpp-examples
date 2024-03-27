# arrow_table_partition

Example of partitioning a Table by unique values in a column.

This is basically the C++ equivalent of this type of PyArrow code:

```python
import pyarrow as pa

table = pa.table([
    pa.array(["a", "a", "b", "b", "c"]),
    pa.array([1, 2, 3, 4, 5]),
], names=["keys", "values"])

r = table.group_by("keys").aggregate([
    ("values", "hash_list")
])
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

## Pre-requisites

- Modern C++ compiler toolchain
- CMake
- Likely a few system libraries, depending on your system
- The data below is [starwars](https://dplyr.tidyverse.org/reference/starwars.html) from dplyr
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

```sh
$ ./example starwars.parquet
homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Tatooine",
      "Naboo",
      "Alderaan",
      "Stewjon",
      "Eriadu",
      "Kashyyyk",
      "Corellia",
      "Rodia",
      "Nal Hutta",
      "Bestine IV",
      ...
      "Serenno",
      "Concord Dawn",
      "Zolan",
      "Ojom",
      "Skako",
      "Muunilinst",
      "Shili",
      "Umbara",
      "Utapau",
      "Kalee"
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
      ],
      [
        "Droid",
        "Human",
        "Human",
        "Gungan",
        "Gungan",
        "Gungan",
        "Human",
        "Human",
        null,
        null,
        "Human"
      ],
      ...
      [
        "Pau'an"
      ],
      [
        "Kaleesh"
      ]
    ]
  ]
```
