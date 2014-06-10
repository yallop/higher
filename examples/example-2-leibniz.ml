(* Leibniz equality using the Higher library.

   From Section 2.2 of

      Lightweight Higher-Kinded Polymorphism
      Jeremy Yallop and Leo White
      Functional and Logic Programming 2014
*)
      
open Higher

module Leibniz :
sig
  module Eq : Newtype2

  type ('a, 'b) eq = ('b, ('a, Eq.t) app) app
  (** A value of type [(a, b) eq] is a proof that the types [a] and [b] are
      equal. *)

  val refl : unit -> ('a, 'a) eq
  (** Equality is reflexive: [refl ()] builds a proof that any type [a] is
      equal to itself. *)

  val subst : ('a, 'b) eq -> ('a, 'f) app -> ('b, 'f) app
  (** If types [a] and [b] are equal then they are interchangeable in any
      context [f]. *)

  val trans : ('a, 'b) eq -> ('b, 'c) eq -> ('a, 'c) eq
  (** Equality is transitive: if [a] and [b] are equal and [b] and [c] are
      equal then [a] and [c] are equal. *)

  val symm : ('a, 'b) eq -> ('b, 'a) eq
  (** Equality is symmetric: if [a] and [b] are equal then [b] and [a] are
      equal *)

  val cast : ('a, 'b) eq -> 'a -> 'b
  (** If types [a] and [b] are equal then we can coerce a value of type [a] to
     a value of type [b]. *)
end =
struct
  module Id = Newtype1(struct type 'a t = 'a end)
    
  type ('a, 'b) eqaux = { eqaux : 'f. ('a, 'f) app -> ('b, 'f) app }
  (** The proof of equality of types [a] and [b] is implemented as a coercion
      from [a] to [b] in an arbitrary context [f]. *)

  module Eq = Newtype2(struct type ('b, 'a) t = ('a, 'b) eqaux end)

  type ('a, 'b) eq = ('b, ('a, Eq.t) app) app
    
  let refl () = Eq.inj { eqaux = fun x -> x }
  let subst ab ctxt = (Eq.prj ab).eqaux ctxt
  let trans ab bc = subst bc ab
  let cast eq x = Id.prj (subst eq (Id.inj x))
  let symm (type a) eq =
    let module S = Newtype1(struct type 'a t = ('a, a) eq end) in
    S.prj (subst eq (S.inj (refl ())))
end
