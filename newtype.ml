(* Representation of type application.  This corresponds to the "apply"
   variant type in a defunctionalized program.  Application is postfix. *)
type ('p, 'f) app = ..

(* Isomorphisms. *)
type ('a, 'b) iso = { inj : 'a -> 'b; prj : 'b -> 'a; }

(* Injection operates at kind Star. *)
let inj : 'a 'b. ('a, 'b) iso -> 'a -> 'b =
  fun {inj} -> inj

(* Projection operates at kind Star. *)
let prj : 'a 'b. ('a, 'b) iso -> 'b -> 'a =
  fun {prj} -> prj

(* Some useful constructors for building newtypes *)
let primitive = { inj = (fun x -> x); prj = (fun x -> x) }

module Param (S : sig type 'a repr end) : sig
  type t
  val t : ('a S.repr, ('a, t) app) iso
end =
struct
  type t
  type (_, _) app += App : 'a S.repr -> ('a, t) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end

module Param2 (S : sig type ('a, 'b) repr end) : sig
  type t
  val t : (('a, 'b) S.repr, ('b, ('a, t) app) app) iso
end =
struct
  type t
  type (_, _) app += App : ('a, 'b) S.repr -> ('b, ('a, t) app) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end
