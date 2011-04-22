-module(erl_play).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
erl_play_sup:start_link().

stop(_State) ->
ok.
