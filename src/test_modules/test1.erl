-module(test1).

-export([test/0]).
-include("test.hrl").
-compile({parse_transform,dump_code}).
-compile({parse_transform,dummy_transform}).
-compile({parse_transform,dump_code}).

test() -> ok.


