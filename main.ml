open Setup
open Machinen

exception Error

let usage_msg : Arg.usage_msg =
"Usage : ./main.native [option] configuration
Where configuration is in the following format:
  rotor1_index rotor1_position rotor2_index rotor2_position rotor3_index rotor3_position reflector_index permutation_table
And the permutation table is given in the following format: \"AB CD\" if you want to permute A<->B and C<->D.
"

let argument_position = ref 0

let anon_fun s =
  let open Enigml in
  incr argument_position;
  match !argument_position with
  | 1 -> position.walze1_index <- int_of_string s
  | 3 -> position.walze2_index <- int_of_string s
  | 5 -> position.walze3_index <- int_of_string s
  | 7 -> position.ukw_index <- int_of_string s
  | 2 -> position.walze1_position <- to_letter s.[0]
  | 4 -> position.walze2_position <- to_letter s.[0]
  | 6 -> position.walze3_position <- to_letter s.[0]
  | _ -> steckerbrett := (to_letter s.[0], to_letter s.[1])::!steckerbrett

let select_machine s =
  machine_choice := match s with
  | "test" | "Test" -> test_machine
  | "M3" | "m3" | _ -> m3_machine

let speclist =
  [
  "--machine", Arg.String select_machine, "Select a machine. Available machines are: M3, test";
  "-m", Arg.String select_machine, "Same as --machine"
  ]

let rec main_loop () =
  try
    let plaintext = read_line () in
    let cipher = !machine_choice (Enigml.permut_of_list !steckerbrett)
      position (Enigml.decompose plaintext) in
    Enigml.print_letters cipher;
    print_newline ();
    main_loop ()
  with
  | End_of_file -> ()
  | _ -> raise Error

let _ =
  Arg.parse speclist anon_fun usage_msg;
  main_loop ()
