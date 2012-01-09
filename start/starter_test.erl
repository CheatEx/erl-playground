-module(starter_test).
-export([run_test/0]).

run_test() ->
    starter:run_starter(),
    GoodTry = starter:start(an_atom, fun foo/0),
    io:format("A good try result:~p~n", [GoodTry]),
    BadTry = starter:start(an_atom, fun foo/0),
    io:format("A bad try result:~p~n", [BadTry]).

foo() ->
    receive
    after 1000 ->
        io:format("Fooo!!!~n", []),
        foo()
    end.

