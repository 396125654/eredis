%% Public types

-type reconnect_sleep() :: no_reconnect | integer().

-type option() :: {host, string()} | {port, integer()} | {database, string()} | {password, string()} | {reconnect_sleep, reconnect_sleep()}.
-type server_args() :: [option()].

-type return_value() :: undefined | binary() | [binary() | nonempty_list()].

-type pipeline() :: [iolist()].

-type channel() :: binary().

%% Continuation data is whatever data returned by any of the parse
%% functions. This is used to continue where we left off the next time
%% the user calls parse/2.
-type continuation_data() :: any().
-type parser_state() :: status_continue | bulk_continue | multibulk_continue.

%% Internal types
-ifdef(namespaced_types).
-type eredis_queue() :: queue:queue().
-else.
-type eredis_queue() :: queue().
-endif.

%% Internal parser state. Is returned from parse/2 and must be
%% included on the next calls to parse/2.
-record(pstate, {
          state = undefined :: parser_state() | undefined,
          continuation_data :: continuation_data() | undefined
}).

-define(NL, "\r\n").

-define(SOCKET_OPTS, [binary, {active, once}, {packet, raw}, {reuseaddr, true}, {keepalive, true}]).

-define(RECV_TIMEOUT, 5000).

-define(HIBERNATE_TIMEOUT, application:get_env(eredis, hibernate_timeout, hibernate)).
