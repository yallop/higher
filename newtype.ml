open Iso

(* Representation of type application.  This corresponds to the "apply"
   variant type in a defunctionalized program.  Application is postfix. *)
type ('p, 'f) app = ..

module Newtype0 (T : sig type t end) : sig
  type t
  val t : (T.t, t) iso
end =
struct
  type t = Id of T.t
  let t = { inj = (fun v -> Id v); prj = (fun (Id v) -> v) }
end

module Newtype1 (T : sig type 'a t end) : sig
  type t
  val t : ('a T.t, ('a, t) app) iso
end =
struct
  type t
  type (_, _) app += App : 'a T.t -> ('a, t) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end

module Newtype2 (T : sig type ('a, 'b) t end) : sig
  type t
  val t : (('a, 'b) T.t, ('b, ('a, t) app) app) iso
end =
struct
  type t
  type (_, _) app += App : ('a, 'b) T.t -> ('b, ('a, t) app) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end

module Newtype3 (T : sig type ('a, 'b, 'c) t end) : sig
  type t
  val t : (('a, 'b, 'c) T.t, ('c, ('b, ('a, t) app) app) app) iso
end =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c) T.t -> ('c, ('b, ('a, t) app) app) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end

module Newtype4 (T : sig type ('a, 'b, 'c, 'd) t end) : sig
  type t
  val t : (('a, 'b, 'c, 'd) T.t, ('d, ('c, ('b, ('a, t) app) app) app) app) iso
end =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd) T.t -> ('d, ('c, ('b, ('a, t) app) app) app) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end

module Newtype5 (T : sig type ('a, 'b, 'c, 'd, 'e) t end) : sig
  type t
  val t : (('a, 'b, 'c, 'd, 'e) T.t, ('e, ('d, ('c, ('b, ('a, t) app) app) app) app) app) iso
end =
struct
  type t
  type (_, _) app += App : ('a, 'b, 'c, 'd, 'e) T.t -> ('e, ('d, ('c, ('b, ('a, t) app) app) app) app) app
  let t = { inj = (fun v -> App v); prj = (fun (App v) -> v) }
end
