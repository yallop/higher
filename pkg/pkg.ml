#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "higher" @@ fun c ->
  Ok [ Pkg.mllib "src/higher.mllib" ]
