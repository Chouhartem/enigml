open Enigml

let test_initial_position = 
  { walze1_index =  0;
  walze1_position = I;
  walze2_index =    1;
  walze2_position = V;
  walze3_index =    2;
  walze3_position = M;
  ukw_index =       0 }
let test_steckerbrett = permut_of_list [ B, J; C, L; M, U ]

let enigmaI_initial_position = 
  { walze1_index =  1;
  walze1_position = K;
  walze2_index =    0;
  walze2_position = V;
  walze3_index =    2;
  walze3_position = P;
  ukw_index =       1 }
let enigmaI_steckerbrett = permut_of_list [ A, X; Q, V; N, K; D, U; B, L ]

let (initial_position:rotors_state) = 
  { walze1_index =  0;
  walze1_position = A;
  walze2_index =    1;
  walze2_position = A;
  walze3_index =    2;
  walze3_position = A;
  ukw_index =       1 }

let (steckerbrett:permutation ref) = ref (permut_of_list [ A,B ; X, U; L, K ])

let (machine_choice: machine ref) = ref Machinen.m3_machine
