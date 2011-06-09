-module(erl_play_web).
-export([start/1, stop/0, loop/2]).
%% External API
start(Options) ->
    {DocRoot, Options1} = get_option(docroot, Options),
    Loop = fun (Req) ->
        ?MODULE:loop(Req, DocRoot)
    end,
    %we'll set our maximum to 1 million connections.
    mochiweb_http:start([{max, 1000000}, {name, ?MODULE}, {loop, Loop} | Options1]).


stop() ->
    mochiweb_http:stop(?MODULE).

loop(Req, DocRoot) ->
    "/" ++ Path = Req:get(path),
    case Req:get(method) of
        Method when Method =:= 'GET'; Method =:= 'HEAD' ->
            case Path of
                "test/" ++ Id ->
                    Response = Req:ok({"text/html; charset=utf-8",
                                        [{"Server","Mochiweb-Test"}],
                                        chunked}),
                    router:login(list_to_atom(Id), self()),
                    feed(Response, Id, 1);
                _ ->
                    Req:not_found()
            end;
        'POST' ->
            case Path of
                _ ->
                    Req:not_found()
                end;
        _ ->
            Req:respond({501, [], []})
    end.

feed(Response, Path, N) ->
    receive
        {router_msg, Msg} ->
            Html = io_lib:format("Recvd msg #~w: '~s'", [N, Msg]),
            Response:write_chunk(Html)
    end,
        feed(Response, Path, N+1).

%% Internal API
get_option(Option, Options) ->
    {proplists:get_value(Option, Options), proplists:delete(Option, Options)}.

