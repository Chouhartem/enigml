open Enigml

(** Description of the different machines *)

module Test_state : STATE = struct 
  module Walze1 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "OLFIDUHWBCETYMKAJRVZGXSPQN"
    end
      let n = K end)

  module Walze2 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "BTFGQAJPVSEMKIWUODNZYLRXCH"
  end
      let n = D end)

  module Walze3 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "PZDAWBCNKVXUMRLIYSOTEJQHFG"
  end
      let n = Y end)

  module Walze4 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "YDASXOFUVGMCLJTWQZPNHEBIRK"
    end
      let n = E end)

  module Walze5 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "HQBMWVTUEZLKFGRAXINJPOCSYD"
  end
      let n = R end)

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
      let n = R end)

  module Walze2 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "AJDKSIRUXBLHWTMCQGZNPYFVOE"
  end
      let n = F end)

  module Walze3 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "BDFHJLCPRTXVZNYEIWGAKMUSQO"
  end
      let n = W end)

  module Walze4 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "ESOVPZJAYQUIRHXLNFTGKDCMWB"
    end
      let n = K end)

  module Walze5 = Rotor1 (struct
    module P = struct
      let permut = permut_of_string "VZBRGITYUPSDNHLXAWMJQOFECK"
  end
      let n = A end)

  module Umkehrwalze = struct
    let permut = permut_of_string "YRUHQSLDPXNGOKMIEBFZCWVJAT"
  end
end

module M3_Machine : MACHINE = Make(M3_state)
