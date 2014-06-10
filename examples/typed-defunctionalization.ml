(* An example of typed defunctionalization.

   From Section 1.2 of

      Lightweight Higher-Kinded Polymorphism
      Jeremy Yallop and Leo White
      Functional and Logic Programming 2014
*)

(** A higher-order program: folds over lists, together with functions
    defined using folds. *)
module Original =
struct
  let rec fold : type a b. (a * b -> b) * b * a list -> b =
    fun (f, u, l) -> match l with
     | [] -> u
     | x :: xs -> f (x, fold (f, u, xs))

  let sum l = fold ((fun (x, y) -> x + y), 0, l)
  let add (n, l) = fold ((fun (x, l') -> x + n :: l'), [], l)
end


(** The higher-order program in defunctionalized form. *)
module Defunctionalized =
struct
  type (_, _) arrow =
    Fn_plus : ((int * int), int) arrow
  | Fn_plus_cons : int -> ((int * int list), int list) arrow

  let apply : type a b. (a, b) arrow * a -> b =
    fun (appl, v) -> match appl with
     | Fn_plus -> let (x, y) = v in x + y
     | Fn_plus_cons n -> let (x, l') = v in x + n :: l'

  let rec fold : type a b. (a * b, b) arrow * b * a list -> b =
   fun (f, u, l) -> match l with
    | [] -> u
    | x :: xs -> apply (f, (x, fold (f, u, xs)))

  let sum l = fold (Fn_plus, 0, l)
  let add (n, l) = fold (Fn_plus_cons n, [], l)
end
