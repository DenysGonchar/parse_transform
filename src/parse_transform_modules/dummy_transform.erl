-module(dummy_transform).
-export([parse_transform/2]).
%-compile(export_all).

parse_transform(Code,_Opts) -> Code.
