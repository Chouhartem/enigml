open Enigml

(** Description of the different machines *)

module Test_state : STATE = struct 
  module Walze1 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "OLFIDUHWBCETYMKAJRVZGXSPQN"
    end
      let i = K end)

  module Walze2 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "BTFGQAJPVSEMKIWUODNZYLRXCH"
  end
      let i = D end)

  module Walze3 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "PZDAWBCNKVXUMRLIYSOTEJQHFG"
  end
      let i = Y end)

  module Walze4 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "YDASXOFUVGMCLJTWQZPNHEBIRK"
    end
      let i = E end)

  module Walze5 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "HQBMWVTUEZLKFGRAXINJPOCSYD"
  end
      let i = R end)

  module Umkehrwalze = struct
    let permut = permut_of_string "NOPQRSTUVWXYZABCDEFGHIJKLM"
  end
end

module Test_Machine : MACHINE = Make(Test_state)
(* The Test Machine *)

(** M3 Army Enigma *)
module M3_state : STATE = struct
  module Walze1 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
    end
      let i = R end)

  module Walze2 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "AJDKSIRUXBLHWTMCQGZNPYFVOE"
  end
      let i = F end)

  module Walze3 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "BDFHJLCPRTXVZNYEIWGAKMUSQO"
  end
      let i = W end)

  module Walze4 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "ESOVPZJAYQUIRHXLNFTGKDCMWB"
    end
      let i = K end)

  module Walze5 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "VZBRGITYUPSDNHLXAWMJQOFECK"
  end
      let i = A end)

  module Umkehrwalze = struct
    let permut = permut_of_string "YRUHQSLDPXNGOKMIEBFZCWVJAT"
  end
end

module M3_Machine : MACHINE = Make(M3_state)
