# Mála

ETS bags, an in-memory table where one key can have multiple values.

[![Package Version](https://img.shields.io/hexpm/v/mala)](https://hex.pm/packages/mala)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/mala/)

```sh
gleam add mala@1
```
```gleam
import mala

pub fn main() -> Nil {
  let bag = mala.new()
  mala.insert(bag, "numbers", 1)
  mala.insert(bag, "numbers", 2)
  mala.insert(bag, "numbers", 3)
  assert mala.get(bag, "numbers") == Ok([1, 2, 3])
}
```

Further documentation can be found at <https://hexdocs.pm/mala>.
