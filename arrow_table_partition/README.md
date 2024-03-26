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

TODO

## Building

TODO

## Running

TODO

## Example Output

TODO
