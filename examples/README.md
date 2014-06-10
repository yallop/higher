The code in this directory is taken from the paper "Lightweight Higher-Kinded Polymorphism" (Jeremy Yallop and Leo White).

Most of the code depends on the [higher][higher] library, which you can install using [opam][opam].  Once higher is installed you can load the examples into the top level directly:

```
  $ ocaml
        OCaml version 4.01.0

  # #use "topfind";;
  [...]
  # #require "higher";;
  [...]
  # #use "example-1-perfect-trees.ml";;
  type 'a perfect = Zero of 'a | Succ of ('a * 'a) perfect
  [...]
  # 
```

[higher]: https://github.com/ocamllabs/higher
[opam]: http://opam.ocaml.org/