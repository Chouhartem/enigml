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
  let assoc = List.combine image letters in
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

module Permut (M : sig val desc : letter list end) : PERMUT = struct
  open M
  let permut l = 
    let assoc = List.combine letters desc in
    List.assoc l assoc
end

module type ROTOR = sig
  val turn : int
  val permut : rotor_state -> letter -> letter
  val action : int -> rotor_state -> letter -> int * rotor_state * letter
end

module Rotor (M : sig module P: PERMUT val i: int end ) : ROTOR = struct
  open M
  let turn = i 
  let permut s l =
    iter prev (P.permut (iter next l s)) s
  let action b s l =
    let next_state = (b + s) mod 26 in
    let next_turn () = 
      if next_state == turn && b == 1 then
        1
      else
        0
    in
    next_turn (), next_state, permut s l
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

module Make (S : STATE) : MACHINE = struct
  open S
  let encrypt =
    let enc_letter (p1, p2, p3) l =
      let l = Steckerbrett.permut l in
      let b2, s1, l = Walze1.action 1 p1 l in
      let b3, s2, l = Walze2.action b2 p2 l in
      let _ , s3, l = Walze3.action b3 p3 l in
      let l = Umkehrwalze.permut l in
      let l = inverse (Walze3.permut p3) l in
      let l = inverse (Walze2.permut p2) l in
      let l = inverse (Walze1.permut p1) l in
      let l = inverse Steckerbrett.permut l in
      (s1, s2, s3, l)
    in let rec loop res position = function
      | [] -> List.rev res
      | h::t -> begin
        let p1, p2, p3, l = enc_letter position h in
        loop (l::res) (p1, p2, p3) t
      end
    in loop []
end
