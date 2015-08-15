open Enigml

(** Description of the different machines *)

module Test_state : STATE = struct 
  let walzen = [|
    rotor1 (permut_of_string "OLFIDUHWBCETYMKAJRVZGXSPQN") K;
    rotor1 (permut_of_string "BTFGQAJPVSEMKIWUODNZYLRXCH") D;
    rotor1 (permut_of_string "PZDAWBCNKVXUMRLIYSOTEJQHFG") Y;
    rotor1 (permut_of_string "YDASXOFUVGMCLJTWQZPNHEBIRK") E;
    rotor1 (permut_of_string "HQBMWVTUEZLKFGRAXINJPOCSYD") R; |]

  module Umkehrwalze = struct
    let permut = permut_of_string "NOPQRSTUVWXYZABCDEFGHIJKLM"
  end
end

module Test_Machine : MACHINE = Make(Test_state)
(* The Test Machine *)

(** M3 Army Enigma *)
module M3_state : STATE = struct
  let walzen = [|
    rotor1 (permut_of_string "EKMFLGDQVZNTOWYHXUSPAIBRCJ") R;
    rotor1 (permut_of_string "AJDKSIRUXBLHWTMCQGZNPYFVOE") F;
    rotor1 (permut_of_string "BDFHJLCPRTXVZNYEIWGAKMUSQO") W;
    rotor1 (permut_of_string "ESOVPZJAYQUIRHXLNFTGKDCMWB") K;
    rotor1 (permut_of_string "VZBRGITYUPSDNHLXAWMJQOFECK") A;
    rotor2 (permut_of_string "JPGVOUMFYQBENHZRDKASXLICTW") A N;
    rotor2 (permut_of_string "NZJHGRCXMYSWBOUFAIVLPEKQDT") A N;
    rotor2 (permut_of_string "FKQHTLXOCBJSPDZRAMEWNIUYGV") A N |]
  module Umkehrwalze = struct
    let permut = permut_of_string "YRUHQSLDPXNGOKMIEBFZCWVJAT"
  end
end

module M3_Machine : MACHINE = Make(M3_state)
