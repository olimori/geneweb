(* camlp4r *)
(* $Id: templAst.mli,v 4.1 2002-01-16 12:07:21 ddr Exp $ *)
(* Copyright (c) 2002 INRIA *)

type ast =
  [ Atext of string
  | Avar of string and list string
  | Atransl of bool and string and string
  | Awid_hei of string
  | Aif of ast_expr and list ast and list ast
  | Aforeach of string and list string and list ast
  | Adefine of string and list string and list ast and list ast
  | Aapply of string and list ast_expr ]
and ast_expr =
  [ Eor of ast_expr and ast_expr
  | Eand of ast_expr and ast_expr
  | Eop of string and ast_expr and ast_expr
  | Enot of ast_expr
  | Estr of string
  | Eint of string
  | Evar of string and list string
  | Etransl of bool and string and string ]
;