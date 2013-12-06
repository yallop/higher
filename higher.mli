(** Operations on newtypes *)

(** Type expression application. *)
type ('p, 'f) app

(** Construct a newtype for a type constructor with no parameters. *)
module type Newtype0 = sig
  type s
  type t
  val inj : s -> t 
  val prj : t -> s
end
module Newtype0 (T : sig type t end)
  : Newtype0 with type s := T.t

(** Construct a newtype for a type constructor with one parameter. *)
module type Newtype1 = sig
  type 'a s
  type t
  val inj : 'a s -> ('a, t) app 
  val prj : ('a, t) app -> 'a s
end
module Newtype1 (T : sig type 'a t end)
  : Newtype1 with type 'a s := 'a T.t

(** Construct a newtype for a type constructor with two parameters. *)
module type Newtype2 = sig
  type ('a, 'b) s
  type t
  val inj : ('a, 'b) s -> ('a, ('b, t) app) app 
  val prj : ('a, ('b, t) app) app -> ('a, 'b) s
end
module Newtype2 (T : sig type ('a, 'b) t end)
  : Newtype2 with type ('a, 'b) s := ('a, 'b) T.t

(** Construct a newtype for a type constructor with three parameters. *)
module type Newtype3 = sig
  type ('a, 'b, 'c) s
  type t
  val inj : ('a, 'b, 'c) s -> ('a, ('b, ('c, t) app) app) app 
  val prj : ('a, ('b, ('c, t) app) app) app -> ('a, 'b, 'c) s
end
module Newtype3 (T : sig type ('a, 'b, 'c) t end)
  : Newtype3 with type ('a, 'b, 'c) s := ('a, 'b, 'c) T.t

(** Construct a newtype for a type constructor with four parameters. *)
module type Newtype4 = sig
  type ('a, 'b, 'c, 'd) s
  type t
  val inj : ('a, 'b, 'c, 'd) s -> ('a, ('b, ('c, ('d, t) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, t) app) app) app) app -> ('a, 'b, 'c, 'd) s
end
module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end)
  : Newtype4 with type ('a, 'b, 'c, 'd) s := ('a, 'b, 'c, 'd) T.t

(** Construct a newtype for a type constructor with five parameters. *)
module type Newtype5 = sig
  type ('a, 'b, 'c, 'd, 'e) s
  type t
  val inj : ('a, 'b, 'c, 'd, 'e) s -> ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app -> ('a, 'b, 'c, 'd, 'e) s
end
module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end)
  : Newtype5 with type ('a, 'b, 'c, 'd, 'e) s := ('a, 'b, 'c, 'd, 'e) T.t

(** Construct a newtype for a type constructor with six parameters. *)
module type Newtype6 = sig
  type ('a, 'b, 'c, 'd, 'e, 'f) s
  type t
  val inj : ('a, 'b, 'c, 'd, 'e, 'f) s -> ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app -> ('a, 'b, 'c, 'd, 'e, 'f) s
end
module Newtype6 (T : sig type ('a, 'b, 'c, 'd, 'e, 'f) t end)
  : Newtype6 with type ('a, 'b, 'c, 'd, 'e, 'f) s := ('a, 'b, 'c, 'd, 'e, 'f) T.t
