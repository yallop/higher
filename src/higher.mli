(** Operations on newtypes *)

(** Type expression application. *)
type ('p, 'f) app

(** Construct a newtype for a type constructor with no parameters. *)
module type Newtype0 = sig
  type s
  type t
  external inj : s -> t
    = "%identity"
  external prj : t -> s
    = "%identity"
end
module Newtype0 (T : sig type t end)
  : Newtype0 with type s = T.t

(** Construct a newtype for a type constructor with one parameter. *)
module type Newtype1 = sig
  type 'a s
  type t
  external inj : 'a s -> ('a, t) app 
    = "%identity"
  external prj : ('a, t) app -> 'a s
    = "%identity"
end
module Newtype1 (T : sig type 'a t end)
  : Newtype1 with type 'a s = 'a T.t

(** Construct a newtype for a type constructor with two parameters. *)
module type Newtype2 = sig
  type ('a, 'b) s
  type t
  external inj : ('a, 'b) s -> ('a, ('b, t) app) app 
    = "%identity"
  external prj : ('a, ('b, t) app) app -> ('a, 'b) s
    = "%identity"
end
module Newtype2 (T : sig type ('a, 'b) t end)
  : Newtype2 with type ('a, 'b) s = ('a, 'b) T.t

(** Construct a newtype for a type constructor with three parameters. *)
module type Newtype3 = sig
  type ('a, 'b, 'c) s
  type t
  external inj : ('a, 'b, 'c) s -> ('a, ('b, ('c, t) app) app) app 
    = "%identity"
  external prj : ('a, ('b, ('c, t) app) app) app -> ('a, 'b, 'c) s
    = "%identity"
end
module Newtype3 (T : sig type ('a, 'b, 'c) t end)
  : Newtype3 with type ('a, 'b, 'c) s = ('a, 'b, 'c) T.t

(** Construct a newtype for a type constructor with four parameters. *)
module type Newtype4 = sig
  type ('a, 'b, 'c, 'd) s
  type t
  external inj : ('a, 'b, 'c, 'd) s ->
    ('a, ('b, ('c, ('d, t) app) app) app) app
    = "%identity"
  external prj : ('a, ('b, ('c, ('d, t) app) app) app) app ->
    ('a, 'b, 'c, 'd) s
    = "%identity"
end
module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end)
  : Newtype4 with type ('a, 'b, 'c, 'd) s = ('a, 'b, 'c, 'd) T.t

(** Construct a newtype for a type constructor with five parameters. *)
module type Newtype5 = sig
  type ('a, 'b, 'c, 'd, 'e) s
  type t
  external inj : ('a, 'b, 'c, 'd, 'e) s ->
    ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app 
    = "%identity"
  external prj : ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app ->
    ('a, 'b, 'c, 'd, 'e) s
    = "%identity"
end
module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end)
  : Newtype5 with type ('a, 'b, 'c, 'd, 'e) s = ('a, 'b, 'c, 'd, 'e) T.t

(** Construct a newtype for a type constructor with six parameters. *)
module type Newtype6 = sig
  type ('a, 'b, 'c, 'd, 'e, 'f) s
  type t
  external inj : ('a, 'b, 'c, 'd, 'e, 'f) s ->
    ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app 
    = "%identity"
  external prj : ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app ->
    ('a, 'b, 'c, 'd, 'e, 'f) s
    = "%identity"
end
module Newtype6 (T : sig type ('a, 'b, 'c, 'd, 'e, 'f) t end)
  : Newtype6 with type ('a, 'b, 'c, 'd, 'e, 'f) s = ('a, 'b, 'c, 'd, 'e, 'f) T.t
