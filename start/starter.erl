-define(TIMEOUT, 1000).

-module(starter).
-export([start/2, run_starter/0]).

start(Atom, Fun) ->
   ?MODULE ! {start, self(), Atom, Fun},
    receive
        {?MODULE, ok, Pid} ->
            {ok, Pid};
        {?MODULE, error, duplicate} ->
            {error, duplicate}
    after ?TIMEOUT ->
        {error, timeout}
	end.

loop() ->
    receive
        {start, StarterPid, Atom, Fun} ->
            case whereis(Atom) of
                undefined ->
                    Pid = register(Atom, spawn(Fun)),
                    StarterPid ! {?MODULE, ok, Pid};
                Pid when is_pid(Pid) ->
                    StarterPid ! {?MODULE, error, duplicate};
				Any ->
					io:format("Unknown message received by the starter process ~p~n", [Any])
            end;
        Any ->
            io:format("Received:~p~n", [Any])
    end,
    loop().

run_starter() ->
    Pid = spawn(fun loop/0),
    register(?MODULE, Pid).
