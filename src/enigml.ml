type letter = A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | Space

type permutation = letter -> letter

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

let rec add a = function
  | A -> a
  | b -> add (next a) (prev b)

let rec sub a = function
  | A -> a
  | b -> sub (prev a) (next b)

let inverse (permut : permutation) ltr =
  let image = List.rev_map permut letters |> List.rev in
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
    in decompose_aux [] size |> List.rev_map to_letter |> List.rev

let print_letters s = List.rev_map of_letter s |> List.rev |> List.iter print_char

type rotor_state = letter
type rotors_state = {
  mutable walze1_index : int;
  mutable walze1_position : rotor_state;
  mutable walze2_index : int;
  mutable walze2_position : rotor_state;
  mutable walze3_index : int;
  mutable walze3_position : rotor_state;
  mutable ukw_index : int }

let permut_of_list desc l =
  let assoc = List.rev_append desc ( List.rev_map (fun (x,y) -> (y,x)) desc) in
  try
    List.assoc l assoc
  with _ ->  l

let permut_of_string desc l =
  let assoc = List.combine letters (decompose (desc ^ " ")) in
  try
    List.assoc l assoc
  with _ -> Space

type rotor = {permut : rotor_state -> permutation;
  action : bool -> rotor_state -> letter -> bool * rotor_state * letter}

let rotor1 p n =
  let notch = n in
  let permut s l =
    sub (p (add l s)) s
  in let action b s l =
    let next_state () = if b then next s else s in
    let next_turn =
      b && next_state () == notch
    in
    next_turn, next_state (), permut s l
  in {permut = permut; action = action}

let rotor2 p n1 n2 =
  let notch1 = n1
  in let notch2 = n2
  in let permut s l =
    sub (p (add l s)) s
  in let action b s l =
    let next_state () = if b then next s else s in
    let next_turn =
      b && (next_state () == notch1 || next_state () == notch2)
    in
    next_turn, next_state (), permut s l
  in {permut = permut; action = action}

type state = { walzen : rotor array;
umkehrwalze: permutation array}

type machine = permutation -> rotors_state -> letter list -> letter list

let make s steckerbrett rotors_s =
  let rotor1, position1, rotor2, position2, rotor3, position3, reflector =
    s.walzen.(rotors_s.walze1_index), rotors_s.walze1_position,
    s.walzen.(rotors_s.walze2_index), rotors_s.walze2_position,
    s.walzen.(rotors_s.walze3_index), rotors_s.walze3_position,
    s.umkehrwalze.(rotors_s.ukw_index) in
  let enc_letter (p1, p2, p3) l =
    let l = steckerbrett l in
    let b2, s1, l = rotor1.action true p1 l in
    let b3, s2, l = rotor2.action b2 p2 l in
    let _, s2, _  = rotor2.action b3 s2 l in (* double increment *)
    let _ , s3, l = rotor3.action b3 p3 l in
    let l = reflector l in
    let l = inverse (rotor3.permut p3) l in
    let l = inverse (rotor2.permut p2) l in
    let l = inverse (rotor1.permut p1) l in
    let l = steckerbrett l in
    (s1, s2, s3, l)
  in let rec loop res position = function
    | [] -> begin
              let p1, p2, p3 = position in
              rotors_s.walze1_position <- p1;
              rotors_s.walze2_position <- p2;
              rotors_s.walze3_position <- p3;
              List.rev res
            end
    | h::t -> begin
      let p1, p2, p3, l = enc_letter position h in
      loop (l::res) (p1, p2, p3) t
    end
  in loop [] (position1, position2, position3)
