(* The codensity transform using the Higher library.

   From Section 2.3 of

      Lightweight Higher-Kinded Polymorphism
      Jeremy Yallop and Leo White
      Functional and Logic Programming 2014
*)

open Higher

(* class Monad *)
class virtual ['m] monad = object
  method virtual return : 'a. 'a -> ('a, 'm) app
  method virtual bind : 'a 'b. ('a, 'm) app -> ('a -> ('b, 'm) app) -> ('b, 'm) app
end

(* class Functor *)
class virtual ['f] functor_ = object
  method virtual fmap : 'a 'b. ('a -> 'b) -> ('a, 'f) app -> ('b, 'f) app
end

(* class (Functor f, Monad m) => Freelike f m *)
class virtual ['f, 'm] freelike (pf : 'f functor_) (mm : 'm monad) = object
  method pf : 'f functor_ = pf
  method mm : 'm monad = mm
  method virtual wrap : 'a. (('a, 'm) app, 'f) app -> ('a, 'm) app
end

(* newtype C m a = C { forall b. (a -> m b) -> m b } *)
type ('a, 'm) c = { c : 'b. ('a -> ('b, 'm) app) -> ('b, 'm) app }
module C = Newtype2(struct type ('a, 'm) t = ('a, 'm) c end)

(* instance Monad (C m) *)
let monad_c () = object
  inherit [('m, C.t) app] monad
  method return a = C.inj {c = fun h -> h a }
  method bind =
    let bind = fun { c = p } k -> {c = fun h -> p (fun a -> (k a).c h) } in
      fun m k -> (C.inj (bind (C.prj m) (fun a -> C.prj (k a))))
end

(* rep :: Monad m => m a -> C m a *)
let rep : 'a 'm. 'm #monad -> ('a, 'm) app -> ('a, 'm) c =
  fun o m -> { c = fun k -> o#bind m k }

(* abs :: Monad m => C m a -> m a *)
let abs : 'a 'm. 'm #monad -> ('a, 'm) c -> ('a, 'm) app =
  fun o c -> c.c o#return

(* data Free = Return a | Wrap (f (Free f a)) *)
type ('a, 'f) free = Return of 'a | Wrap of (('a, 'f) free, 'f) app
module Free = Newtype2(struct type ('a, 'f) t = ('a, 'f) free end)

(* instance Functor f => Monad (Free f) *)
let monad_free (functor_free : 'f #functor_) = object
  inherit [('f, Free.t) app] monad
  method return v = Free.inj (Return v)
  method bind = 
    let rec bind m k = match m with
      | Return a -> k a
      | Wrap t -> Wrap (functor_free#fmap (fun m -> bind m k) t) in
    fun m k -> Free.inj (bind (Free.prj m) (fun a -> Free.prj (k a)))
end

(* instance Functor f => FreeLike (Free f) *)
let freelike_free (ff : 'f #functor_) = object
  inherit ['f,  ('f, Free.t) app] freelike ff (monad_free ff)
  method wrap =
    (* We need the fmap to handle the conversion between ('a, 'f)
       free and the app version in the argument of Wrap *)
    fun x -> Free.inj (Wrap (ff#fmap Free.prj x))
end

(* instance FreeLike f m => FreeLike f (C m) *)
let freelike_c (f_functor : 'f #functor_) (freelike : ('f, 'm) #freelike) =
object
  inherit ['f, ('m, C.t) app] freelike f_functor (monad_c ())
  method wrap t =
    C.inj { c = fun h ->
      freelike#wrap (f_functor#fmap (fun p -> (C.prj p).c h) t)}
end

type ('a, 'f) freelike_poly = {
  fl: 'm 'd. (('f, 'm) #freelike as 'd) -> ('a, 'm) app
}

(* improve :: Functor f => (forall m. FreeLike f m => m a) -> Free f a *)
let improve : 'a 'f. 'f #functor_ -> ('a, 'f) freelike_poly -> ('a, 'f) free =
  fun d { fl } -> Free.prj (abs (monad_free d)
                              (C.prj (fl (freelike_c d 
                                          (freelike_free d)))))

(* data F_IO b = GetChar (Char -> b) | PutChar Char b *)
type 'b f_io = GetChar of (char -> 'b) | PutChar of char * 'b
module F_io = Newtype1(struct type 'b t = 'b f_io end)

(* instance Functor F_IO *)
let functor_f_io = object
  inherit [F_io.t] functor_
  method fmap h l = F_io.inj (match F_io.prj l with
  | GetChar f -> GetChar (fun x -> h (f x))
  | PutChar (c, x) -> PutChar (c, h x))
end

(* getChar :: FreeLike F_IO m => m Char *)
let getChar : 'm. (F_io.t, 'm) #freelike -> (char, 'm) app
  = fun f -> f#wrap (F_io.inj (GetChar f#mm#return))

(* putChar :: FreeLike F_IO m => Char -> m () *)
let putChar : 'm. (F_io.t, 'm) #freelike -> char -> (unit, 'm) app
  = fun f c -> f#wrap (F_io.inj (PutChar (c, (f#mm#return ()))))

(* revEcho :: FreeLike F_IO m => m () *)
let rec revEcho : 'm. (F_io.t, 'm) #freelike -> (unit, 'm) app
  = fun f ->
    let (>>=) c = f#mm#bind c in
    getChar f >>= fun c ->
    if (c <> ' ') then
      (revEcho f >>= fun () ->
       putChar f c)
    else f#mm#return ()

(* data Output a = Read (Output a) | Print Char (Output a) | Finish a *)
type 'a output = Read of 'a output | Print of char * 'a output | Finish of 'a

(* run :: Free F_IO a -> Stream Char -> Output a *)
let rec run : 'a. ('a, F_io.t) free -> char list -> 'a output =
  fun f cs -> match f with
  | Return a -> Finish a
  | Wrap x ->
    match F_io.prj x with
    | GetChar f -> Read (run (f (List.hd cs)) (List.tl cs))
    | PutChar (c, p) -> Print (c, run p cs)

(* run revEcho stream *)
let simulate_original stream =
  run (Free.prj (revEcho (freelike_free functor_f_io)))
    stream

(* run (improve revEcho) stream *)
let simulate_improved stream =
  run (improve functor_f_io { fl = fun d -> revEcho d }) stream
