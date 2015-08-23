open Enigml

let (position:rotors_state) = 
  { walze1_index =  0;
  walze1_position = A;
  walze2_index =    1;
  walze2_position = A;
  walze3_index =    2;
  walze3_position = A;
  ukw_index =       1 }

let (steckerbrett:(letter * letter) list ref) = ref []

let (machine_choice: machine ref) = ref Machinen.m3_machine
