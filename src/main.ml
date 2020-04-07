open Setup
open Machinen

let usage_msg : Arg.usage_msg =
"Usage : " ^ Sys.argv.(0) ^ " [-m machine] configuration [-p passphrase]
Where configuration is in the following format:
  012 ABC 0 AB CD
Where:
  - the first argument represents the rotors order (indices start at 1)
  - the second argument represents the rotors initial state
  - the third argument represents the reflector choice
  - the remaining arguments represent the permutation table, here \"AB CD\" means
    that A <-> B and C <-> D
The possible options are:"

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

let session_pass s =
  let open Enigml in
  if String.length s != 3 then
    failwith "Error: the session password must be 3 characters long"
  else begin
    let plaintext = s ^ s in
    let cipher = !machine_choice (permut_of_list !steckerbrett)
      position (decompose plaintext) in
    print_letters cipher;
    position.walze1_position <- to_letter s.[0];
    position.walze2_position <- to_letter s.[1];
    position.walze3_position <- to_letter s.[2]
  end

let speclist =
  [
  "--machine", Arg.String select_machine, "Select a machine. Available machines are: M3, test";
  "-m", Arg.String select_machine, "Same as --machine";
  "--pass", Arg.String session_pass, "Set a session password for the file encrypt. Use it as last argument";
  "-p", Arg.String session_pass, "Same as --pass"
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
  | _ -> failwith "Unknown error"

let rec test_uniq = function
  | [] -> true
  | (k,_)::t -> begin
      if List.mem_assoc k t then
        false
      else
        test_uniq t
    end

let _ =
  Arg.parse speclist anon_fun usage_msg;
  if test_uniq (List.rev_append !steckerbrett (List.rev_map (fun (x,y) -> (y,x)) !steckerbrett)) then 
    main_loop ()
  else
    failwith "Duplicate in Steckerbrett"
