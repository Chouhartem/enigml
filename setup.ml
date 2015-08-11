open Enigml

let initial_position = (0, I, 1 , V, 2, M)

module State : STATE = struct 
  module Walze1 = Rotor1 (struct
    module P = struct
      let permut = function
        | A -> O | B -> L | C -> F | D -> I | E -> D | F -> U | G -> H | H -> W
        | I -> B | J -> C | K -> E | L -> T | M -> Y | N -> M | O -> K | P -> A
        | Q -> J | R -> R | S -> V | T -> Z | U -> G | V -> X | W -> S | X -> P
        | Y -> Q | Z -> N | Space -> Space
    end
      let i = K end)

  module Walze2 = Rotor1 (struct
    module P = struct
      let permut = function
        | A -> B | B -> T | C -> F | D -> G | E -> Q | F -> A | G -> J | H -> P
        | I -> V | J -> S | K -> E | L -> M | M -> K | N -> I | O -> W | P -> U
        | Q -> O | R -> D | S -> N | T -> Z | U -> Y | V -> L | W -> R | X -> X
        | Y -> C | Z -> H | Space -> Space
  end
      let i = D end)

  module Walze3 = Rotor1 (struct
    module P = struct
      let permut = function
        | A -> P | B -> Z | C -> D | D -> A | E -> W | F -> B | G -> C | H -> N
        | I -> K | J -> V | K -> X | L -> U | M -> M | N -> R | O -> L | P -> I
        | Q -> Y | R -> S | S -> O | T -> T | U -> E | V -> J | W -> Q | X -> H
        | Y -> F | Z -> G | Space -> Space
  end
      let i = Y end)

  module Walze4 = Rotor1 (struct
    module P = struct
      let permut = function
        | A -> Y | B -> D | C -> A | D -> S | E -> X | F -> O | G -> F | H -> U
        | I -> V | J -> G | K -> M | L -> C | M -> L | N -> J | O -> T | P -> W
        | Q -> Q | R -> Z | S -> P | T -> N | U -> H | V -> E | W -> B | X -> I
        | Y -> R | Z -> K | Space -> Space
  end
      let i = E end)

  module Walze5 = Rotor1 (struct
    module P = struct
      let permut = function
        | A -> H | B -> Q | C -> B | D -> M | E -> W | F -> V | G -> T | H -> U
        | I -> E | J -> Z | K -> L | L -> K | M -> F | N -> G | O -> R | P -> A
        | Q -> X | R -> I | S -> N | T -> J | U -> P | V -> O | W -> C | X -> S
        | Y -> Y | Z -> D | Space -> Space
  end
      let i = R end)

  module Umkehrwalze = struct
    let permut = function
      | A -> N | B -> O | C -> P | D -> Q | E -> R | F -> S | G -> T | H -> U
      | I -> V | J -> W | K -> X | L -> Y | M -> Z | N -> A | O -> B | P -> C
      | Q -> D | R -> E | S -> F | T -> G | U -> H | V -> I | W -> J | X -> K
      | Y -> L | Z -> M | Space -> Space
  end

  module Steckerbrett = struct
    let permut = function
      | A -> A | B -> J | C -> L | D -> D | E -> E | F -> F | G -> G | H -> H
      | I -> I | J -> B | K -> K | L -> C | M -> U | N -> N | O -> O | P -> P
      | Q -> Q | R -> R | S -> S | T -> T | U -> M | V -> V | W -> W | X -> X
      | Y -> Y | Z -> Z | Space -> Space
  end
end

module Machine : MACHINE = Make(State)
