#!/bin/sh
#cd (*
exec ocaml $0
*) ".";;
(* $Id: lex_sort.sh,v 4.1 2001-04-05 13:59:42 ddr Exp $ *)

open Printf

let linenum = ref 0
let input_line_cnt ic = incr linenum; input_line ic

let rec skip_to_same_line ic line_ref =
  let line = input_line_cnt ic in
  printf "%s\n" line;
  if line = line_ref then ()
  else skip_to_same_line ic line_ref

let rec get_all_versions ic =
  let line = try input_line_cnt ic with End_of_file -> "" in
  if line = "" then []
  else if String.length line < 3 then begin
    eprintf "small line %d: \"%s\"\n" !linenum (String.escaped line);
    flush stderr;
    []
  end
  else
    try
      let i = String.index line ':' in
      let lang = String.sub line 0 i in
      let transl = String.sub line (i + 1) (String.length line - i - 1) in
      (lang, transl) :: get_all_versions ic
    with Not_found ->
      []

let compare_assoc (l1, _) (l2, _) = l1 <= l2

let lex_sort () =
  linenum := 0;
  let ic_lex = open_in "../hd/lang/lexicon.txt" in
  let ic_i18n = open_in "i18n" in
  let rec loop line =
    skip_to_same_line ic_lex ("    " ^ line);
    let list = get_all_versions ic_lex in
    let list = List.sort (fun (l1, _) (l2, _) -> compare l1 l2) list in
    List.iter (fun (lang, str) -> printf "%s:%s\n" lang str) list;
    match try Some (input_line ic_i18n) with End_of_file -> None with
      Some line -> printf "\n"; loop line
    | None -> ()
  in
  loop (input_line ic_i18n)

let _ = lex_sort ();
flush stdout
