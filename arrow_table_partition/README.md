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

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Utapau"
    ]
  ]
species_list:
  [
    [
      [
        "Pau'an"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Muunilinst"
    ]
  ]
species_list:
  [
    [
      [
        "Muun"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Skako"
    ]
  ]
species_list:
  [
    [
      [
        "Skakoan"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Zolan"
    ]
  ]
species_list:
  [
    [
      [
        "Clawdite"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Concord Dawn"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Serenno"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Quermia"
    ]
  ]
species_list:
  [
    [
      [
        "Quermian"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Glee Anselm"
    ]
  ]
species_list:
  [
    [
      [
        "Nautolan"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Iktotch"
    ]
  ]
species_list:
  [
    [
      [
        "Iktotchi"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Cerea"
    ]
  ]
species_list:
  [
    [
      [
        "Cerean"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Iridonia"
    ]
  ]
species_list:
  [
    [
      [
        "Zabrak"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Haruun Kal"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Umbara"
    ]
  ]
species_list:
  [
    [
      [
        null
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Champala"
    ]
  ]
species_list:
  [
    [
      [
        "Chagrian"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Troiken"
    ]
  ]
species_list:
  [
    [
      [
        "Xexto"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Aleen Minor"
    ]
  ]
species_list:
  [
    [
      [
        "Aleena"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Ojom"
    ]
  ]
species_list:
  [
    [
      [
        "Besalisk"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Ryloth"
    ]
  ]
species_list:
  [
    [
      [
        "Twi'lek",
        "Twi'lek"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Shili"
    ]
  ]
species_list:
  [
    [
      [
        "Togruta"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Malastare"
    ]
  ]
species_list:
  [
    [
      [
        "Dug"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Toydaria"
    ]
  ]
species_list:
  [
    [
      [
        "Toydarian"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Coruscant"
    ]
  ]
species_list:
  [
    [
      [
        "Human",
        "Tholothian",
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Cato Neimoidia"
    ]
  ]
species_list:
  [
    [
      [
        "Neimodian"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Sullust"
    ]
  ]
species_list:
  [
    [
      [
        "Sullustan"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Endor"
    ]
  ]
species_list:
  [
    [
      [
        "Ewok"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Mon Cala"
    ]
  ]
species_list:
  [
    [
      [
        "Mon Calamari"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Geonosis"
    ]
  ]
species_list:
  [
    [
      [
        "Geonosian"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Dorin"
    ]
  ]
species_list:
  [
    [
      [
        "Kel Dor"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Kamino"
    ]
  ]
species_list:
  [
    [
      [
        "Human",
        "Kaminoan",
        "Kaminoan"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Chandrila"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Socorro"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Bestine IV"
    ]
  ]
species_list:
  [
    [
      [
        null
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Nal Hutta"
    ]
  ]
species_list:
  [
    [
      [
        "Hutt"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Tund"
    ]
  ]
species_list:
  [
    [
      [
        "Toong"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Rodia"
    ]
  ]
species_list:
  [
    [
      [
        "Rodian"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      null
    ]
  ]
species_list:
  [
    [
      [
        "Yoda's species",
        "Droid",
        "Human",
        "Human",
        "Droid",
        "Human",
        "Human",
        "Human",
        "Droid",
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Corellia"
    ]
  ]
species_list:
  [
    [
      [
        "Human",
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Vulpter"
    ]
  ]
species_list:
  [
    [
      [
        "Vulptereen"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Kashyyyk"
    ]
  ]
species_list:
  [
    [
      [
        "Wookiee",
        "Wookiee"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Dathomir"
    ]
  ]
species_list:
  [
    [
      [
        "Zabrak"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Bespin"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Eriadu"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Stewjon"
    ]
  ]
species_list:
  [
    [
      [
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Kalee"
    ]
  ]
species_list:
  [
    [
      [
        "Kaleesh"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Alderaan"
    ]
  ]
species_list:
  [
    [
      [
        "Human",
        "Human",
        "Human"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Trandosha"
    ]
  ]
species_list:
  [
    [
      [
        "Trandoshan"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Naboo"
    ]
  ]
species_list:
  [
    [
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
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
  child 0, item: string
----
homeworld:
  [
    [
      "Mirial"
    ]
  ]
species_list:
  [
    [
      [
        "Mirialan",
        "Mirialan"
      ]
    ]
  ]

homeworld: string
species_list: list<item: string>
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


```
