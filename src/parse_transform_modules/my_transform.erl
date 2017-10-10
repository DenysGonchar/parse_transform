-module(my_transform).
-export([parse_transform/2]).

parse_transform(Code, Opts) ->
  io:format("~p~n", [{Code, Opts}]),
  Code.


%% Also you can check erl_id_trans module,
%% which is included in OTP as an example
