(** Enigma machine simulator in OCaml
 
    This module provides the tools to construct an enigma machine of type
    {!machine}
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

val to_letter : char -> letter
(** Convert a [char] to its [letter] equivalent *)

val print_letters : letter list -> unit
(** Print a list of [letter]s *)

type rotor_state = letter
type rotors_state = {
  mutable walze1_index : int; (** The leftmost rotor index *)
  mutable walze1_position : rotor_state; (** The leftmost rotor position *)
  mutable walze2_index : int; (** The middle rotor index *)
  mutable walze2_position : rotor_state; (** The middle rotor position *)
  mutable walze3_index : int; (** The rightmost rotor index *)
  mutable walze3_position : rotor_state; (** The rightmost rotor position *)
  mutable ukw_index : int (** The reflector index *) }
(** The rotors' state. *)

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
(** The input type of an enigma machine construction. *)

type machine = permutation -> rotors_state -> letter list -> letter list
(** The signature of an enigml machine. To use a machine, the arguments are :
    the steckerbrett, the initial state of the rotors, that gives a function
    that transforms a plaintext into its ciphertext.
    
    {b Warning:} This has the side-effect to change the rotors_state to set the
    rotors position at their stop position *)

val make : state -> machine
(** The function that create an enigma machine from a state *)
