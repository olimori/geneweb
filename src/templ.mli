(* camlp4r *)
(* $Id: templ.mli,v 4.13 2005-06-11 21:22:49 ddr Exp $ *)

open Config;
open Def;
open TemplAst;

exception Exc_located of loc and exn;

value input : config -> string -> list ast;

value eval_transl : config -> bool -> string -> string -> string;
value eval_bool_expr :
  config -> (loc -> list string -> expr_val * string -> list string -> string)
    -> ast -> bool;
value eval_int_expr :
  config -> (loc -> list string -> expr_val * string -> list string -> string)
    -> ast -> int;
value eval_expr :
  config -> (loc -> list string -> expr_val * string -> list string -> string)
    -> ast -> string;
value eval_subst : string -> list string -> list string -> ast -> ast;
value eval_string_var :
   config -> (list string -> expr_val) -> string -> list string -> string;

value print_var :
   config -> base -> (list string -> expr_val) -> string -> list string ->
     unit;
value print_apply :
   config -> string -> (ast -> unit) ->
     (loc -> list string -> expr_val * string -> list string -> string) ->
     list string -> list ast -> list (list ast) -> unit;
