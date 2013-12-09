
(* Representation of type application.  This corresponds to the "apply"
   variant type in a defunctionalized program.  Application is postfix. *)
type ('p, 'f) app = ..

module type Newtype0 = sig
  type s
  type t
  val inj : s -> t 
  val prj : t -> s
end

module type Newtype1 = sig
  type 'a s
  type t
  val inj : 'a s -> ('a, t) app 
  val prj : ('a, t) app -> 'a s
end

module type Newtype2 = sig
  type ('a, 'b) s
  type t
  val inj : ('a, 'b) s -> ('a, ('b, t) app) app 
  val prj : ('a, ('b, t) app) app -> ('a, 'b) s
end

module type Newtype3 = sig
  type ('a, 'b, 'c) s
  type t
  val inj : ('a, 'b, 'c) s -> ('a, ('b, ('c, t) app) app) app 
  val prj : ('a, ('b, ('c, t) app) app) app -> ('a, 'b, 'c) s
end

module type Newtype4 = sig
  type ('a, 'b, 'c, 'd) s
  type t
  val inj : ('a, 'b, 'c, 'd) s -> ('a, ('b, ('c, ('d, t) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, t) app) app) app) app -> ('a, 'b, 'c, 'd) s
end

module type Newtype5 = sig
  type ('a, 'b, 'c, 'd, 'e) s
  type t
  val inj : ('a, 'b, 'c, 'd, 'e) s -> ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app -> ('a, 'b, 'c, 'd, 'e) s
end

module type Newtype6 = sig
  type ('a, 'b, 'c, 'd, 'e, 'f) s
  type t
  val inj : ('a, 'b, 'c, 'd, 'e, 'f) s -> ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app 
  val prj : ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app -> ('a, 'b, 'c, 'd, 'e, 'f) s
end

module Newtype0 (T : sig type t end) =
struct
  type t = Id of T.t
  let inj v = Id v
  let prj (Id v) = v
end

module Newtype1 (T : sig type 'a t end) =
struct
  type t
  type (_, _) app += App : 'a T.t -> ('a, t) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype2 (T : sig type ('a, 'b) t end) =
struct
  type t
  type (_, _) app += App : ('a, 'b) T.t -> ('a, ('b, t) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype3 (T : sig type ('a, 'b, 'c) t end) =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c) T.t -> ('a, ('b, ('c, t) app) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end) =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd) T.t -> ('a, ('b, ('c, ('d, t) app) app) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end) =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd, 'e) T.t -> ('a, ('b, ('c, ('d, ('e, t) app) app) app) app) app
  let inj v = App v
  let prj (App v) = v
end

module Newtype6 (T : sig type ('a, 'b, 'c, 'd, 'e, 'f) t end) =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd, 'e, 'f) T.t -> ('a, ('b, ('c, ('d, ('e, ('f, t) app) app) app) app) app) app
  let inj v = App v
  let prj (App v) = v
end
