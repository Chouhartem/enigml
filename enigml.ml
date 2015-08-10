type letter = A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q
| R | S | T | U | V | W | X | Y | Z | Space

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
  | A -> 'A' | B -> 'B' | C -> 'C' | D -> 'D' | E -> 'E' | F -> 'F' | G -> 'G' |
  H -> 'H' | I -> 'I' | J -> 'J' | K -> 'K' | L -> 'L' | M -> 'M' | N -> 'N' |
  O -> 'O' | P -> 'P' | Q -> 'Q' | R -> 'R' | S -> 'S' | T -> 'T' | U -> 'U' |
  V -> 'V' | W -> 'W' | X -> 'X' | Y -> 'Y' | Z -> 'Z' | Space -> ' '

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
