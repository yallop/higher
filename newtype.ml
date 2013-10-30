(* Base kinds *)
type star = Kind_star

(* Representation of type application.  This corresponds to the "apply"
   variant type in a defunctionalized program.  Application is postfix. *)
type ('p, 'f) app = ..

(* Isomorphisms. *)
type ('a, 'b) iso = { inj : 'a -> 'b; prj : 'b -> 'a; }

(* Newtype type constructors: *)
type ('rep, 'brand, 'kind) newtype =
    (* Base type constructor *)
    Star : ('rep, 'brand) iso -> ('rep, 'brand, star) newtype

    (* Arrow type constructor *)
  | Arr : ('rep2, ('brand1, 'brand2) app, 'kind2) newtype -> 
          ('brand1 -> 'rep2, 'brand2, 'kind1 -> 'kind2) newtype

(* Argument instantiation *)
let (~~) : type repr brand1 brand2 kind1 kind2.
  (brand2 -> repr, brand1, kind1 -> kind2) newtype ->
  (repr, (brand2, brand1) app, kind2) newtype =
  fun (Arr f) -> f


(* Injection operates at kind Star. *)
let inj : 'rep 'brand. ('rep, 'brand, star) newtype -> 'rep -> 'brand =
  fun (Star {inj}) -> inj

(* Projection operates at kind Star. *)
let prj : 'rep 'brand. ('rep, 'brand, star) newtype -> 'brand -> 'rep =
  fun (Star {prj}) -> prj

(* Some useful constructors for building newtypes *)
let primitive = Star { inj = (fun x -> x); prj = (fun x -> x) }
module Param (S : sig type 'a repr type argkind end) : sig
  type t
  val t : ('a -> 'a S.repr, t, S.argkind -> star) newtype
end =
struct
  type t
  type (_, _) app += App : 'a S.repr -> ('a, t) app
  let t = Arr (Star { inj = (fun v -> App v); prj = (fun (App v) -> v) })
end

module Param2 (S : sig type ('a, 'b) repr type argkind1 type argkind2 end) : sig
  type t
  val t : ('a -> 'b -> ('a, 'b) S.repr, t, S.argkind1 -> S.argkind2 -> star) newtype
end =
struct
  type t
  type (_, _) app += App : ('a, 'b) S.repr -> ('b, ('a, t) app) app
  let t = Arr (Arr (Star { inj = (fun v -> App v); prj = (fun (App v) -> v) }))
end
