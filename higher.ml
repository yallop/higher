
(* Representation of type application.  This corresponds to the "apply"
   variant type in a defunctionalized program.  Application is postfix. *)
type ('p, 'f) app = ..

module Newtype0 (T : sig type t end) : sig
  type t
  val inj : T.t -> t
  val prj : t -> T.t
end =
struct
  type t = Id of T.t
  let inj v = Id v
  let prj (Id v) = v
end

module Newtype1 (T : sig type 'a t end) : sig
  type t
  val inj : 'a T.t -> ('a, t) app
  val prj : ('a, t) app -> 'a T.t
end =
struct
  type t
  type (_, _) app += App : 'a T.t -> ('a, t) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype2 (T : sig type ('a, 'b) t end) : sig
  type t
  val inj : ('a, 'b) T.t -> ('b, ('a, t) app) app
  val prj : ('b, ('a, t) app) app -> ('a, 'b) T.t
end =
struct
  type t
  type (_, _) app += App : ('a, 'b) T.t -> ('b, ('a, t) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype3 (T : sig type ('a, 'b, 'c) t end) : sig
  type t
  val inj : ('a, 'b, 'c) T.t -> ('c, ('b, ('a, t) app) app) app 
  val prj : ('c, ('b, ('a, t) app) app) app -> ('a, 'b, 'c) T.t
end =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c) T.t -> ('c, ('b, ('a, t) app) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end) : sig
  type t
  val inj : ('a, 'b, 'c, 'd) T.t -> ('d, ('c, ('b, ('a, t) app) app) app) app 
  val prj : ('d, ('c, ('b, ('a, t) app) app) app) app -> ('a, 'b, 'c, 'd) T.t
end =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd) T.t -> ('d, ('c, ('b, ('a, t) app) app) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end) : sig
  type t
  val inj : ('a, 'b, 'c, 'd, 'e) T.t -> ('e, ('d, ('c, ('b, ('a, t) app) app) app) app) app 
  val prj : ('e, ('d, ('c, ('b, ('a, t) app) app) app) app) app -> ('a, 'b, 'c, 'd, 'e) T.t
end =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd, 'e) T.t -> ('e, ('d, ('c, ('b, ('a, t) app) app) app) app) app
  let inj v = App v
  let prj (App v) = v
end
