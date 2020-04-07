open Enigml

(** Description of the different machines *)

let test_state = {
  walzen = [|
    rotor1 (permut_of_string "OLFIDUHWBCETYMKAJRVZGXSPQN") K;
    rotor1 (permut_of_string "BTFGQAJPVSEMKIWUODNZYLRXCH") D;
    rotor1 (permut_of_string "PZDAWBCNKVXUMRLIYSOTEJQHFG") Y;
    rotor1 (permut_of_string "YDASXOFUVGMCLJTWQZPNHEBIRK") E;
    rotor1 (permut_of_string "HQBMWVTUEZLKFGRAXINJPOCSYD") R; |];

    umkehrwalze = [| permut_of_string "NOPQRSTUVWXYZABCDEFGHIJKLM" |]
}

let test_machine = make test_state
(* The Test Machine *)

(** M3 Army Enigma *)
let m3_state = {
  walzen = [|
    rotor1 (permut_of_string "EKMFLGDQVZNTOWYHXUSPAIBRCJ") R;
    rotor1 (permut_of_string "AJDKSIRUXBLHWTMCQGZNPYFVOE") F;
    rotor1 (permut_of_string "BDFHJLCPRTXVZNYEIWGAKMUSQO") W;
    rotor1 (permut_of_string "ESOVPZJAYQUIRHXLNFTGKDCMWB") K;
    rotor1 (permut_of_string "VZBRGITYUPSDNHLXAWMJQOFECK") A;
    rotor2 (permut_of_string "JPGVOUMFYQBENHZRDKASXLICTW") A N;
    rotor2 (permut_of_string "NZJHGRCXMYSWBOUFAIVLPEKQDT") A N;
    rotor2 (permut_of_string "FKQHTLXOCBJSPDZRAMEWNIUYGV") A N |];
  umkehrwalze = [|
    permut_of_string "EJMZALYXVBWFCRQUONTSPIKHGD";
    permut_of_string "YRUHQSLDPXNGOKMIEBFZCWVJAT"; 
    permut_of_string "FVPJIAOYEDRZXWGCTKUQSBNMHL"
  |]
}

let m3_machine = make m3_state
