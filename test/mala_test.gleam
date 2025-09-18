import gleeunit
import mala

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn insert_test() {
  let bag = mala.new()
  assert mala.get(bag, "one") == Ok([])
  assert mala.get(bag, "two") == Ok([])

  assert mala.insert(bag, "one", 1) == Ok(Nil)
  assert mala.get(bag, "one") == Ok([1])
  assert mala.get(bag, "two") == Ok([])

  assert mala.insert(bag, "one", 2) == Ok(Nil)
  assert mala.get(bag, "one") == Ok([1, 2])
  assert mala.get(bag, "two") == Ok([])
}

pub fn insert_multiple_test() {
  let bag = mala.new()
  assert mala.insert(bag, "one", 1) == Ok(Nil)
  assert mala.insert(bag, "one", 2) == Ok(Nil)

  // Duplicates
  assert mala.insert(bag, "one", 3) == Ok(Nil)
  assert mala.insert(bag, "one", 3) == Ok(Nil)
  assert mala.insert(bag, "one", 3) == Ok(Nil)
  assert mala.insert(bag, "one", 3) == Ok(Nil)
  assert mala.get(bag, "one") == Ok([1, 2, 3])
  assert mala.get(bag, "two") == Ok([])
}

pub fn delete_test() {
  let bag = mala.new()
  assert mala.insert(bag, "one", 1) == Ok(Nil)
  assert mala.insert(bag, "one", 2) == Ok(Nil)
  assert mala.insert(bag, "one", 3) == Ok(Nil)

  assert mala.delete(bag, "one", 2) == Ok(Nil)
  assert mala.get(bag, "one") == Ok([1, 3])
  assert mala.get(bag, "two") == Ok([])
}

pub fn delete_key_test() {
  let bag = mala.new()
  assert mala.insert(bag, "one", 1) == Ok(Nil)
  assert mala.insert(bag, "one", 2) == Ok(Nil)
  assert mala.insert(bag, "one", 3) == Ok(Nil)
  assert mala.get(bag, "one") == Ok([1, 2, 3])

  assert mala.delete_key(bag, "one") == Ok(Nil)
  assert mala.get(bag, "one") == Ok([])
  assert mala.get(bag, "two") == Ok([])
}

pub fn delete_value_test() {
  let bag = mala.new()
  assert mala.insert(bag, "one", 1) == Ok(Nil)
  assert mala.insert(bag, "one", 2) == Ok(Nil)
  assert mala.insert(bag, "two", 2) == Ok(Nil)
  assert mala.insert(bag, "two", 3) == Ok(Nil)

  assert mala.get(bag, "one") == Ok([1, 2])
  assert mala.get(bag, "two") == Ok([2, 3])

  assert mala.delete_value(bag, 2) == Ok(2)
  assert mala.get(bag, "one") == Ok([1])
  assert mala.get(bag, "two") == Ok([3])
}

pub fn drop_table_test() {
  let bag = mala.new()
  assert mala.insert(bag, "one", 1) == Ok(Nil)

  mala.drop_table(bag)
  assert mala.insert(bag, "one", 1) == Error(Nil)

  mala.drop_table(bag)
}
