type letter = A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | Space
let letters =
  [A ; B ; C ; D ; E ; F ; G ; H ; I ; J ; K ; L ; M ; N ; O ; P ; Q ; R ; S ; T
  ; U ; V ; W ; X ; Y ; Z ; Space]


let to_letter = function
  | 'a' -> A | 'b' -> B | 'c' -> C | 'd' -> D | 'e' -> E | 'f' -> F | 'g' -> G |
  'h' -> H | 'i' -> I | 'j' -> J | 'k' -> K | 'l' -> L | 'm' -> M | 'n' -> N |
  'o' -> O | 'p' -> P | 'q' -> Q | 'r' -> R | 's' -> S | 't' -> T | 'u' -> U |
  'v' -> V | 'w' -> W | 'x' -> X | 'y' -> Y | 'z' -> Z | 'A' -> A | 'B' -> B |
  'C' -> C | 'D' -> D | 'E' -> E | 'F' -> F | 'G' -> G | 'H' -> H | 'I' -> I |
  'J' -> J | 'K' -> K | 'L' -> L | 'M' -> M | 'N' -> N | 'O' -> O | 'P' -> P |
  'Q' -> Q | 'R' -> R | 'S' -> S | 'T' -> T | 'U' -> U | 'V' -> V | 'W' -> W |
  'X' -> X | 'Y' -> Y | 'Z' -> Z | _ -> Space

let of_letter = function
  | A -> 'A' | B -> 'B' | C -> 'C' | D -> 'D' | E -> 'E' | F -> 'F' | G -> 'G'
  | H -> 'H' | I -> 'I' | J -> 'J' | K -> 'K' | L -> 'L' | M -> 'M' | N -> 'N'
  | O -> 'O' | P -> 'P' | Q -> 'Q' | R -> 'R' | S -> 'S' | T -> 'T' | U -> 'U'
  | V -> 'V' | W -> 'W' | X -> 'X' | Y -> 'Y' | Z -> 'Z' | Space -> ' '

let next = function
  | A -> B | B -> C | C -> D | D -> E | E -> F | F -> G | G -> H | H -> I
  | I -> J | J -> K | K -> L | L -> M | M -> N | N -> O | O -> P | P -> Q
  | Q -> R | R -> S | S -> T | T -> U | U -> V | V -> W | W -> X | X -> Y
  | Y -> Z | Z -> A | Space -> Space

let prev = function
  | A -> Z | B -> A | C -> B | D -> C | E -> D | F -> E | G -> F | H -> G
  | I -> H | J -> I | K -> J | L -> K | M -> L | N -> M | O -> N | P -> O
  | Q -> P | R -> Q | S -> R | T -> S | U -> T | V -> U | W -> V | X -> W
  | Y -> X | Z -> Y | Space -> Space

let iter f =
  let rec iter_aux res = function
    | 0 -> res
    | i -> iter_aux (f res) (pred i)
  in iter_aux 

let inverse (permut:letter->letter) ltr =
  let image = List.map permut letters in
  let assoc = List.combine letters image in
  List.assoc ltr assoc

let decompose s =
  let size = String.length s in
  if size == 0 then
    []
  else
    let rec decompose_aux acc = function
      | 0 -> List.rev acc
      | i -> decompose_aux (s.[size-i]::acc) (pred i)
    in decompose_aux [] size |> List.map to_letter

let print_letters s = List.map of_letter s |> List.iter print_char

type rotor_state = int

module type PERMUT = sig
  val permut : letter -> letter
end

module type ROTOR = sig
  val turn : int
  val action : int -> rotor_state -> letter -> int * rotor_state * letter
end

module Rotor (M : sig module P: PERMUT val i: int end ) : ROTOR = struct
  let turn = M.i 
  let action b s l =
    let next_state = (b + s) mod 26 in
    let next_turn () = 
      if next_state == turn && b == 1 then
        1
      else
        0
    in
    next_turn (), next_state, iter prev (M.P.permut (iter next l s)) s
end

module type STATE = sig
  module Walze1 : ROTOR
  module Walze2 : ROTOR
  module Walze3 : ROTOR
  module Umkehrwalze : PERMUT
  module Steckerbrett : PERMUT
end

module type MACHINE = sig
  val encrypt : (int * int * int) -> letter list -> letter list
end

