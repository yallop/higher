(** Operations on newtypes *)

(** Type expression application. *)
type ('p, 'f) app

(** Construct a newtype for a type constructor with no parameters. *)
module Newtype0 (T : sig type t end) : sig
  type t
  val inj : T.t -> t 
  val prj : t -> T.t
end

(** Construct a newtype for a type constructor with one parameter. *)
module Newtype1 (T : sig type 'a t end) : sig
  type t
  val inj : 'a T.t -> ('a, t) app 
  val prj : ('a, t) app -> 'a T.t
end

(** Construct a newtype for a type constructor with two parameters. *)
module Newtype2 (T : sig type ('a, 'b) t end) : sig
  type t
  val inj : ('a, 'b) T.t -> ('a, ('b, t) app) app 
  val prj : ('a, ('b, t) app) app -> ('a, 'b) T.t
end

(** Construct a newtype for a type constructor with three parameters. *)
module Newtype3 (T : sig type ('a, 'b, 'c) t end) : sig
  type t
  val inj : ('a, 'b, 'c) T.t -> ('a, ('b, ('c, t) app) app) app 
  val prj : ('a, ('b, ('c, t) app) app) app -> ('a, 'b, 'c) T.t
end

(** Construct a newtype for a type constructor with four parameters. *)
module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end) : sig
  type t
  val inj : ('a, 'b, 'c, 'd) T.t -> ('a, ('b, ('c, ('d, t) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, t) app) app) app) app -> ('a, 'b, 'c, 'd) T.t
end

(** Construct a newtype for a type constructor with five parameters. *)
module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end) : sig
  type t
  val inj : ('a, 'b, 'c, 'd, 'e) T.t -> ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app -> ('a, 'b, 'c, 'd, 'e) T.t
end
