(* Folds over perfect trees using the Higher library.

   From Section 2.1 of

      Lightweight Higher-Kinded Polymorphism
      Jeremy Yallop and Leo White
      Functional and Logic Programming 2014
*)

open Higher

type 'a perfect = Zero of 'a | Succ of ('a * 'a) perfect

type 'f perfect_folder = {
  zero: 'a. 'a -> ('a, 'f) app;
  succ: 'a. ('a * 'a, 'f) app -> ('a, 'f) app;
}

let rec foldp : 'f 'a. 'f perfect_folder -> 'a perfect -> ('a, 'f) app =
   fun { zero; succ } -> function
   | Zero l -> zero l
   | Succ p -> succ (foldp { zero; succ } p)

module Perfect = Newtype1(struct type 'a t = 'a perfect end)

let idp p = Perfect.(prj (foldp { zero = (fun l -> inj (Zero l));
                                  succ = (fun b -> inj (Succ (prj b)))} p))
