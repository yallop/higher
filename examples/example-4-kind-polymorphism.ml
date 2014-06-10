(* Kind polymorphism using the Higher library.

   From Section 2.4 of

      Lightweight Higher-Kinded Polymorphism
      Jeremy Yallop and Leo White
      Functional and Logic Programming 2014
*)

open Higher

let id x = x

class virtual ['f] category = object
  method virtual ident : 'a. ('a, ('a, 'f) app) app
  method virtual compose : 'a 'b 'c.
     ('b, ('a, 'f) app) app -> ('c, ('b, 'f) app) app -> ('c, ('a, 'f) app) app
end

module Fun = Newtype2(struct type ('a, 'b) t = 'b -> 'a end)
let category_fun = object
  inherit [Fun.t] category
  method ident = Fun.inj id
  method compose f g = Fun.inj (fun x -> Fun.prj g (Fun.prj f x))
end

type ('n, 'm) ip = { ip: 'a. ('a, 'm) app -> ('a, 'n) app }
module Ip = Newtype2(struct type ('n, 'm) t = ('n, 'm) ip end)
let category_ip = object
  inherit [Ip.t] category
  method ident = Ip.inj { ip = id }
  method compose f g = Ip.inj {ip = fun x -> (Ip.prj g).ip ((Ip.prj f).ip x) }
end

(* The type of category computations in left-associative form.  All
   values are of the form

      Compose (Compose(...(Ident, c1), c2), ... cn)
*)
type ('b, 'a, 'f) cat_left =
| Ident : ('a, 'a, 'f) cat_left
| Compose : ('b, 'a, 'f) cat_left * ('c, ('b, 'f) app) app -> ('c, 'a, 'f) cat_left
module CL = Newtype3(struct type ('b, 'a, 'f) t = ('b, 'a, 'f) cat_left end)

(* An instance of category that puts computations into normal form. *)
let category_cat_left (_ : 'f #category) = object (self)
  inherit [('f, CL.t) app] category
  method ident = CL.inj Ident
  method compose : type a b c. (b, (a, ('f, CL.t) app) app) app -> 
                               (c, (b, ('f, CL.t) app) app) app ->
                               (c, (a, ('f, CL.t) app) app) app =
    fun (type a) (type b) (type c) 
      (f : (b, (a, ('f, CL.t) app) app) app)
      (j : (c, (b, ('f, CL.t) app) app) app) ->
     CL.(match (prj j : (c, b, 'f) cat_left) with
      Ident -> (f : (c, (a, ('f, CL.t) app) app) app)
    | Compose (g, h) -> inj (Compose (prj (self#compose f (inj g)), h)))
end

(* Run a left-associative computation. *)
let rec observe : type f a b. f #category -> (b, a, f) cat_left -> (b, (a, f) app) app =
  fun cat -> function
  | Ident -> cat#ident
  | Compose (f, g) -> cat#compose (observe cat f) g

(* Lift a value into cat_left. *)
let promote : type f a b. (b, (a, f) app) app -> (b, a, f) cat_left =
  fun c  -> Compose (Ident, c)
