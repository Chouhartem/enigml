open Setup
open Machinen

let _ =
  print_string
  "This is enigml, an enigma simulator written in ocaml.\nType your plaintext (avoid spaces even if they are supported)\n> ";
  let plaintext = read_line () in
  let cipher = Test_Machine.encrypt initial_position (Enigml.decompose plaintext) in
  print_string "Ciphertext: ";
  Enigml.print_letters cipher;
  print_newline ();
  print_string "Decryption: ";
  Enigml.print_letters @@ Test_Machine.encrypt initial_position cipher;
  print_newline ()
