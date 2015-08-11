(** Enigma machine simulator in OCaml *)

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
(** The list of letters. *)

val decompose : string -> letter list
(** Decompose a string into a list of [letter]s *)

val print_letters : letter list -> unit
(** Print a list of [letter]s *)

type rotor_state = letter
type rotors_state = int * rotor_state * int * rotor_state * int * rotor_state
(** The rotors state in the following format:
  - Leftmost rotor index and its initial state
  - Middle rotor index and its initial state
  - Rightmost rotor index and its initial state *)

val permut_of_list : (letter * letter) list -> letter -> letter
(** generate a permutation from a list *)

val permut_of_string : string -> letter -> letter
(** generate a permutation from a string *)

module type PERMUT =
  sig
    val permut : letter -> letter
    (** The [permutation] *)
  end
(** The input signature of a [permutation] *)

module type ROTOR =
  sig
    val permut : rotor_state -> letter -> letter
    val action : bool -> rotor_state -> letter -> bool * rotor_state * letter
  end
(** The input signature of a Rotor *)

module Rotor1 :
  functor (M : sig module P : PERMUT val i : letter end) -> ROTOR
(** Construct a type I rotor that acts like an odometer *)

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
(** The input signature of an enigma machine construction:
  - TODO: sepate the and the permutation table (Steckerbrett) *)

module type MACHINE =
  sig
    val encrypt : rotors_state -> letter list -> letter list
  end
(** The signature of an enigml machine *)

module Make : functor (S : STATE) -> MACHINE
(** The functor that create an enigma machine from a state *)
