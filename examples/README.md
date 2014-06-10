The code in this directory is taken from the paper "[Lightweight Higher-Kinded Polymorphism][higher-paper]" (Jeremy Yallop and Leo White).  The following examples are available:

[higher-paper]: https://ocamllabs.github.io/higher/lightweight-higher-kinded-polymorphism.pdf

* [typed defunctionalization](typed-defunctionalization.ml) (Section 1.2)
* [folds over perfect trees](example-1-perfect-trees.ml) (Section 2.1)
* [Leibniz equality](example-2-leibniz.ml) (Section 2.2)
* [the codensity transform](example-3-codensity.ml) (Section 2.3)
* [kind polymorphism](example-4-kind-polymorphism.ml) (Section 2.4)

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
