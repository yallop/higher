(* Base kinds *)
type 'a star = 'a

(* Representation of type application.  This corresponds to the "apply"
   variant type in a defunctionalized program.  Application is postfix. *)
type ('p, 'f) app = ..

(* Isomorphisms. *)
type ('a, 'b) iso = { inj : 'a -> 'b; prj : 'b -> 'a; }

(* Newtype type constructors: *)
type ('rep, 'brand) newtype =
    (* Base type constructor *)
    Star : ('rep, 'brand) iso -> ('rep star, 'brand) newtype

    (* Arrow type constructor *)
  | Arr : ('rep, ('arg, 'brand) app) newtype -> ('arg -> 'rep, 'brand) newtype

(* Argument instantiation *)
let (~~) : 'r 'b 'arg. ('arg -> 'r, 'b) newtype -> ('r, ('arg, 'b) app) newtype =
  fun (Arr f) -> f


(* Injection operates at kind Star. *)
let inj : 'rep 'brand. ('rep star, 'brand) newtype -> 'rep -> 'brand =
  fun (Star {inj}) -> inj

(* Projection operates at kind Star. *)
let prj : 'rep 'brand. ('rep star, 'brand) newtype -> 'brand -> 'rep =
  fun (Star {prj}) -> prj

(* Some useful constructors for building newtypes *)
let primitive = Star { inj = (fun x -> x); prj = (fun x -> x) }
module Param (S : sig type 'a repr end) : sig
  type t
  val t : ('a -> 'a S.repr star, t) newtype
end =
struct
  type t
  type (_, _) app += App : 'a S.repr -> ('a, t) app
  let t = Arr (Star { inj = (fun v -> App v); prj = (fun (App v) -> v) })
end

module Param2 (S : sig type ('a, 'b) repr end) : sig
  type t
  val t : ('a -> 'b -> ('a, 'b) S.repr star, t) newtype
end =
struct
  type t
  type (_, _) app += App : ('a, 'b) S.repr -> ('b, ('a, t) app) app
  let t = Arr (Arr (Star { inj = (fun v -> App v); prj = (fun (App v) -> v) }))
end
