(** Enigma machine simulator in OCaml
 
    This module provides the tools to construct an enigma machine of type
    {!MACHINE}
 *)

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
  | Space (** The space *)
(** The list of letters *)

type permutation = letter -> letter
(** The [permutation] type *)

val decompose : string -> letter list
(** Decompose a string into a list of [letter]s *)

val print_letters : letter list -> unit
(** Print a list of [letter]s *)

type rotor_state = letter
type rotors_state = int * rotor_state * int * rotor_state * int * rotor_state * int
(** The rotors state in the following format:
  - Leftmost {e rotor index} and its {e initial state}
  - Middle {e rotor index} and its {e initial state}
  - Rightmost {e rotor index} and its {e initial state}
  - {e Reflector index}*)

val permut_of_list : (letter * letter) list -> permutation
(** generate a [permutation] from a [list] *)

val permut_of_string : string -> permutation
(** generate a [permutation] from a [string] *)

type rotor = {permut : rotor_state -> permutation;
  action : bool -> rotor_state -> letter -> bool * rotor_state * letter}
(** The [rotor] type. Provides 2 main functions:
   - The permutation induced by the rotor
   - The action of the rotor on its right neighbour (including the [permutation]
   for compactness) *)

val rotor1 : permutation -> letter -> rotor
(** Construct a {e type I} rotor that acts like an odometer *)

val rotor2 : permutation -> letter -> letter -> rotor
(** Construct a {e type II} rotor *)

type state = { walzen : rotor array;
umkehrwalze : permutation array}
(** The input type of an enigma machine construction.
  - {b TODO: separate the state and the reflector (Umkehrwalze)} *)

type machine = permutation -> rotors_state -> letter list -> letter list
(** The signature of an enigml machine. To use a machine, the arguments are :
    the steckerbrett, the initial state of the rotors, that gives a function
    that transforms a plaintext into its ciphertext *)

val make : state -> machine
(** The function that create an enigma machine from a state *)
