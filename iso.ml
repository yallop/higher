(* Simple isomorphims *)

(* Isomorphisms. *)
type ('a, 'b) iso = { inj : 'a -> 'b; prj : 'b -> 'a; }

(* Injection *)
let inj : 'a 'b. ('a, 'b) iso -> 'a -> 'b =
  fun {inj} -> inj

(* Projection *)
let prj : 'a 'b. ('a, 'b) iso -> 'b -> 'a =
  fun {prj} -> prj

(* Identities *)
let identity : 'a. ('a, 'a) iso = 
  { inj = (fun x -> x); prj = (fun x -> x) }

