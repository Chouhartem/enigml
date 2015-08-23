open Setup
open Machinen

exception Error

let usage_msg : Arg.usage_msg =
"Usage : ./main.native [options] configuration
Where configuration is in the following format:
  012 ABC 0 AB CD
Where:
  - the first argument represents the rotors order (indices start at 1)
  - the second argument represents the rotors initial state
  - the third argument represents the reflector choice
  - the remaining arguments represent the permutation table, here \"AB CD\" means
    that A <-> B and C <-> D
The options are:"

let argument_position = ref 0

let anon_fun s =
  let open Enigml in
  incr argument_position;
  match !argument_position with
  | 1 -> let i = int_of_string s in
         position.walze1_index <- (i/100) mod 10 - 1;
         position.walze2_index <- (i/10) mod 10 - 1;
         position.walze3_index <- i mod 10 - 1
  | 2 -> position.walze1_position <- to_letter s.[0];
         position.walze2_position <- to_letter s.[1];
         position.walze3_position <- to_letter s.[2]
  | 3 -> position.ukw_index <- (int_of_string s) - 1
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
