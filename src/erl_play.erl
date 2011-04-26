%% @author Mochi Media <dev@mochimedia.com>
%% @copyright 2010 Mochi Media <dev@mochimedia.com>

%% @doc erl_play.

-module(erl_play).
-author("Mochi Media <dev@mochimedia.com>").
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the erl_play server.
start() ->
    erl_play_deps:ensure(),
    ensure_started(crypto),
    application:start(erl_play).


%% @spec stop() -> ok
%% @doc Stop the erl_play server.
stop() ->
    application:stop(erl_play).
