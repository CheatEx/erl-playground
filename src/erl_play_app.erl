%% @author Mochi Media <dev@mochimedia.com>
%% @copyright erl_play Mochi Media <dev@mochimedia.com>

%% @doc Callbacks for the erl_play application.

-module(erl_play_app).
-author("Mochi Media <dev@mochimedia.com>").

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for erl_play.
start(_Type, _StartArgs) ->
    erl_play_deps:ensure(),
    erl_play_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for erl_play.
stop(_State) ->
    ok.
