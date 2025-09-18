/// An ETS "bag" type table.
///
/// This in memory table can have multiple values for each key.
///
/// See the Erlang documentation for more information:
/// <https://www.erlang.org/doc/apps/stdlib/ets.html>
///
pub type BagTable(k, v)

/// Create a new bag. The protection mode is `public`, so it can be accessed
/// from any process.
///
/// The process that calls this function is the owner of the ETS table, and the
/// table will be dropped when the owner process terminates.
///
@external(erlang, "mala_ffi", "bag_new")
pub fn new() -> BagTable(k, v)

/// Key all values for a given key in the table.
///
/// This function will return an error if the bag has been dropped, either explicitly
/// with `drop_table` or implicitly by the owner process terminating.
///
@external(erlang, "mala_ffi", "bag_get")
pub fn get(table: BagTable(k, v), key: k) -> Result(List(v), Nil)

/// Insert a value for the given key in the table. If the key already has this
/// value then there will be no change.
///
/// This function will return an error if the bag has been dropped, either explicitly
/// with `drop_table` or implicitly by the owner process terminating.
///
@external(erlang, "mala_ffi", "bag_insert")
pub fn insert(table: BagTable(k, v), key: k, value: v) -> Result(Nil, Nil)

/// Delete a key-value pair from the table.
///
/// This function will return an error if the bag has been dropped, either explicitly
/// with `drop_table` or implicitly by the owner process terminating.
///
@external(erlang, "mala_ffi", "bag_delete")
pub fn delete(table: BagTable(k, v), key: k, value: v) -> Result(Nil, Nil)

/// Delete all values for the given key in the table.
///
/// This function will return an error if the bag has been dropped, either explicitly
/// with `drop_table` or implicitly by the owner process terminating.
///
@external(erlang, "mala_ffi", "bag_delete_key")
pub fn delete_key(table: BagTable(k, v), key: k) -> Result(Nil, Nil)

/// Delete all instances of a given value from the table, no matter what key
/// they are stored under.
///
/// This performs a full table scan so is slower than the other operations in
/// this module.
///
/// This function will return an error if the bag has been dropped, either explicitly
/// with `drop_table` or implicitly by the owner process terminating.
///
@external(erlang, "mala_ffi", "bag_delete_value")
pub fn delete_value(table: BagTable(k, v), value: v) -> Result(Int, Nil)

/// Drop a table, freeing the memory it used.
///
/// Any attempt to use a table after it was dropped will result in an error.
///
@external(erlang, "mala_ffi", "drop")
pub fn drop_table(table: BagTable(k, v)) -> Nil
