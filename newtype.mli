(** Operations on newtypes *)

(**
A newtype expression is either
- a brand: a nullary type constructor that uniquely identifies a newtype, or
- an application of a newtype expression to some OCaml type expression

That is,

    newtype-expression := brand
                        | (type-expression, newtype-expression) app

Brands are created by the {!Param} and {!Param2} functors.  Applications are
instantiations of the {!app} type constructor.
*)

type ('rep, 'brand) newtype
(** A description of a newtype.  The components are

- rep, the representation type, which has the form
      arg1 -> arg2 -> ... -> argn -> t star
  for some types arg1 ... argn, t.

- brand, a newtype expression 
*)

type _ star
(** The kind of types. *)

type ('p, 'f) app
(** Type expression application. *)

val inj : ('rep star, 'brand) newtype -> 'rep -> 'brand
(** Inject a value into a newtype.  Injection operates at kind {!star} *)

val prj : ('rep star, 'brand) newtype -> 'brand -> 'rep
(** Projection a value from a newtype.  Projection operates at kind {!star} *)

val (~~) : ('a -> 'repr, 'brand) newtype -> ('repr, ('a, 'brand) app) newtype
(** Instantiation of a parameterized newtype constructor.  For example, given a
constructor for lists

    val list : ('a -> 'a list, List.t, star -> star) newtype

the expression

    (~~ list)

has the type

    ('_a list, ('_a, List.t) app, star) newtype

and the weak type variables will be filled in by unification.
*)


module Param (S : sig type 'a repr end) : sig
  type t
  val t : ('a -> 'a S.repr star, t) newtype
end
(** Construct a newtype for a type constructor with one parameter. *)

module Param2 (S : sig type ('a, 'b) repr end) : sig
  type t
  val t : ('a -> 'b -> ('a, 'b) S.repr star, t) newtype
end
(** Construct a newtype for a type constructor with two parameters. *)
