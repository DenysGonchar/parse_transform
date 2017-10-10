-module(dump_code).
-export([parse_transform/2]).
-define(KEY,?MODULE).
%-compile(export_all).

parse_transform(Code,Opts) ->
  lists:member(?KEY,erlang:get_keys()) orelse erlang:put(?KEY,1),
  Key = erlang:get(?KEY),
  OutDir = case lists:keyfind(outdir,1,Opts) of
             {_,Dir} -> Dir;
             _ -> "./"
           end,
  {attribute,_,_,Module} = lists:keyfind(module,3,Code),
  FileName = lists:flatten(io_lib:format( "~s/~s.P~w",
                                          [OutDir,Module,Key])),
  io:format("code dumpped in ~s~n",[FileName]),
  {ok,File}=file:open(FileName, write),
  ErlCode=erl_prettypr:format(erl_syntax:form_list(Code)),
  io:format(File,"~s",[ErlCode]),
  file:close(File),
  erlang:put(?KEY,Key+1),
  Code.
