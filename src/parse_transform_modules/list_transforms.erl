-module(list_transforms).
-export([parse_transform/2]).
%-compile(export_all).

-define(GUARD,{attribute,0,file,{atom_to_list(?MODULE),0}}).

parse_transform(Code,Opts) ->
  case lists:member(?GUARD,Code) of
    true -> Code;
    false ->
      {attribute,_,_,Module}=lists:keyfind(module,3,Code),
      Mods1=lists:foldr(fun
                          ({parse_transform,?MODULE},_) -> [?MODULE];
                          ({parse_transform,M},R) -> [M|R]; 
                          (_,R) -> R 
                        end, [], Opts),
      dbg:tracer(process,{fun
                            (_,stop) -> stop;
                            ({trace,_,call,{compile,foldl_transform,Args}},_) ->
                              Mods2 = case Args of
                                [M,_,_] -> M; %otp20 and higher
                                [_,M] -> M %otp19
                              end,
                              io:format("transformations applied on '~p' module ~p~n",
                                        [Module,Mods1++Mods2]),
                              dbg:stop(), stop
                          end, ok}),
      dbg:p(self(),[call]),
      dbg:tpl(compile,foldl_transform,[]),
      [?GUARD|Code]
  end.
  
