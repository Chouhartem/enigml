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
(** The list of letters *)

type permutation = letter -> letter
(** The permutation type *)

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

val permut_of_list : (letter * letter) list -> permutation
(** generate a permutation from a list *)

val permut_of_string : string -> permutation
(** generate a permutation from a string *)

module type PERMUT =
  sig
    val permut : permutation
    (** The [permutation] *)
  end
(** The input signature of a [permutation] *)

module type ROTOR =
  sig
    val permut : rotor_state -> permutation
    val action : bool -> rotor_state -> letter -> bool * rotor_state * letter
  end
(** The input signature of a Rotor *)

module Rotor1 :
  functor (M : sig module P : PERMUT val n : letter end) -> ROTOR
(** Construct a type I rotor that acts like an odometer *)

module Rotor2 :
  functor (M : sig module P : PERMUT val n1 : letter val n2 : letter end) -> ROTOR
(** Construct a type II rotor *)

module type STATE =
  sig
    module Walze1 : ROTOR
    module Walze2 : ROTOR
    module Walze3 : ROTOR
    module Walze4 : ROTOR
    module Walze5 : ROTOR
    module Umkehrwalze : PERMUT
  end
(** The input signature of an enigma machine construction:
  - TODO: sepate the and the permutation table (Steckerbrett) *)

module type MACHINE =
  sig
    val encrypt : permutation -> rotors_state -> letter list -> letter list
  end
(** The signature of an enigml machine. To use encrypt, the arguments are : the
     steckerbrett, the initial state of the rotors, that gives a function that
     transforms a plaintext into its ciphertext *)

module Make : functor (S : STATE) -> MACHINE
(** The functor that create an enigma machine from a state *)
