(** Operations on newtypes *)

(** An isomorphism between types *)
type ('a, 'b) iso

(** Type expression application. *)
type ('p, 'f) app

(** Inject a value using an isomorphism *)
val inj : ('a, 'b) iso -> 'a -> 'b

(** Project a value using an isomorphism *)
val prj : ('rep star, 'brand) newtype -> 'brand -> 'rep

val primitive : ('a, 'a) iso

(** Construct a newtype for a type constructor with one parameter. *)
module Param (S : sig type 'a repr end) : sig
  type t
  val t : ('a S.repr, ('a, t) app) iso
end

(** Construct a newtype for a type constructor with two parameters. *)
module Param2 (S : sig type ('a, 'b) repr end) : sig
  type t
  val t : (('a, 'b) S.repr, ('a, ('b, t) app) app) iso
end
