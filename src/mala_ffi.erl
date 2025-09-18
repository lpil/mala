-module(mala_ffi).
-export([
    bag_new/0, bag_get/2, bag_insert/3, bag_delete/3, drop/1,
    bag_delete_value/2, bag_delete_key/2
]).

bag_new() ->
    ets:new(ethos_table, [bag, public]).

bag_get(Bag, Key) ->
    try
        Items1 = ets:lookup(Bag, Key),
        {ok, lists:map(fun(Elem) -> element(2, Elem) end, Items1)}
    catch error:badarg -> {error, nil}
    end.

bag_insert(Bag, Key, Value) ->
    try
        ets:insert(Bag, {Key, Value}),
        {ok, nil}
    catch error:badarg -> {error, nil}
    end.

bag_delete(Bag, Key, Value) ->
    try
        ets:delete_object(Bag, {Key, Value}),
        {ok, nil}
    catch error:badarg -> {error, nil}
    end.

bag_delete_key(Bag, Key) ->
    try
        ets:delete(Bag, Key),
        {ok, nil}
    catch error:badarg -> {error, nil}
    end.

bag_delete_value(Bag, Value) ->
    try
        MatchSpec = {
            '$1',
            [{'==', Value, {element, 2, '$1'}}], 
            [true]
        },
        {ok, ets:select_delete(Bag, [MatchSpec])}
    catch error:badarg -> {error, nil}
    end.

drop(Table) ->
    try
        ets:delete(Table),
        {ok, nil}
    catch error:badarg -> {error, nil}
    end.
