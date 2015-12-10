#!/usr/bin/env ocaml 
#directory "pkg"
#use "topkg.ml"

let () = 
  Pkg.describe "higher" ~builder:(`OCamlbuild []) ([
      Pkg.lib "pkg/META";
      Pkg.lib ~exts:Exts.module_library "higher";
      Pkg.doc "README.md" ]
      @ List.map (fun e -> Pkg.share ("examples/"^e))
        (Array.to_list (Sys.readdir "examples")))

