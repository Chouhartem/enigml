type letter =
    A
  | B
  | C
  | D
  | E
  | F
  | G
  | H
  | I
  | J
  | K
  | L
  | M
  | N
  | O
  | P
  | Q
  | R
  | S
  | T
  | U
  | V
  | W
  | X
  | Y
  | Z
  | Space
val letters : letter list
val to_letter : char -> letter
val of_letter : letter -> char
val next : letter -> letter
val prev : letter -> letter
val iter : ('a -> 'a) -> 'a -> int -> 'a
val inverse : (letter -> letter) -> letter -> letter
val decompose : string -> letter list
val print_letters : letter list -> unit
type rotor_state = int
module type PERMUT = sig val permut : letter -> letter end
module Permut : functor (M : sig val desc : letter list end) -> PERMUT
module type ROTOR =
  sig
    val turn : int
    val permut : rotor_state -> letter -> letter
    val action : int -> rotor_state -> letter -> int * rotor_state * letter
  end
module Rotor : functor (M : sig module P : PERMUT val i : int end) -> ROTOR
module type STATE =
  sig
    module Walze1 : ROTOR
    module Walze2 : ROTOR
    module Walze3 : ROTOR
    module Umkehrwalze : PERMUT
    module Steckerbrett : PERMUT
  end
module type MACHINE =
  sig val encrypt : int * int * int -> letter list -> letter list end
module Make : functor (S : STATE) -> MACHINE
