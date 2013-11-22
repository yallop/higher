(** Operations on newtypes *)

open Iso

(** Type expression application. *)
type ('p, 'f) app

(** Construct a newtype for a type constructor with no parameters. *)
module Newtype0 (T : sig type t end) : sig
  type t
  val t : (T.t, t) iso
end

(** Construct a newtype for a type constructor with one parameter. *)
module Newtype1 (T : sig type 'a t end) : sig
  type t
  val t : ('a T.t, ('a, t) app) iso
end

(** Construct a newtype for a type constructor with two parameters. *)
module Newtype2 (T : sig type ('a, 'b) t end) : sig
  type t
  val t : (('a, 'b) T.t, ('b, ('a, t) app) app) iso
end

(** Construct a newtype for a type constructor with three parameters. *)
module Newtype3 (T : sig type ('a, 'b, 'c) t end) : sig
  type t
  val t : (('a, 'b, 'c) T.t, ('c, ('b, ('a, t) app) app) app) iso
end

(** Construct a newtype for a type constructor with four parameters. *)
module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end) : sig
  type t
  val t : (('a, 'b, 'c, 'd) T.t, ('d, ('c, ('b, ('a, t) app) app) app) app) iso
end

(** Construct a newtype for a type constructor with five parameters. *)
module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end) : sig
  type t
  val t : (('a, 'b, 'c, 'd, 'e) T.t, ('e, ('d, ('c, ('b, ('a, t) app) app) app) app) app) iso
end
