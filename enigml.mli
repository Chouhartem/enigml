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

val decompose : string -> letter list

val print_letters : letter list -> unit

type rotor_state = letter
type rotors_state = int * rotor_state * int * rotor_state * int * rotor_state

module type PERMUT = sig val permut : letter -> letter end

module Permut : functor (M : sig val desc : letter list end) -> PERMUT

module type ROTOR =
  sig
    val permut : rotor_state -> letter -> letter
    val action : bool -> rotor_state -> letter -> bool * rotor_state * letter
  end

module Rotor1 :
  functor (M : sig module P : PERMUT val i : letter end) -> ROTOR

module type STATE =
  sig
    module Walze1 : ROTOR
    module Walze2 : ROTOR
    module Walze3 : ROTOR
    module Walze4 : ROTOR
    module Walze5 : ROTOR
    module Umkehrwalze : PERMUT
    module Steckerbrett : PERMUT
  end

module type MACHINE =
  sig
    val rotors : ((rotor_state -> letter -> letter) * (bool -> rotor_state ->
      letter -> bool * rotor_state * letter)) array
    val encrypt : rotors_state -> letter list -> letter list
  end

module Make : functor (S : STATE) -> MACHINE
