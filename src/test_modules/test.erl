-module(test).
-compile([{parse_transform, my_transform},export_all]).

print(X) when is_atom(X) ->
  io:format("~p", [X]).

