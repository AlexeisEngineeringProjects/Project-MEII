disp("=======================================================================");
disp("                       ME2_Solver Utility ");
disp("          coded by Crivcianschi Alexei, TUCN, march 2025");         
disp("-----------------------------------------------------------------------"); 
disp("              Starting your script... Please wait!");
disp("=======================================================================");
%------------------------------------------------------------------------------
% run with this command from ME2_solver terminal
run(fullfile(pwd, '..', 'lib', 'Init.m'));

% run with this command from Matlab
% run(fullfile(pwd, 'lib', 'Init.m'));
%------------------------------------------------------------------------------
run("T1_Dimensions.m");
%------------------------------------------------------------------------------
run("T2_Stator.m");
%------------------------------------------------------------------------------
fprintf("\nstart running T3 Script\np = %d\n\nZ1 = %d\n\n", p, Z1);

fprintf("\nAlegeti Z2 conform tabelului:\n");
disp([' ┌────────────┬───────────────┬────────────────────────────────────────────┬────────────────────────────────────────────┐'; ...
      ' │ Nr. perechi│  crestaturi   │           Nr. crestaturi DREPTE            │           Nr. crestaturi ÎNCLINATE         │'; ...
      ' │   poli p   │   stator Z1   │             ale rotorului Z2               │               ale rotorului Z2             │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     1      │      24       │ 32                                         │ 31, 33, 34, 35                             │'; ...
      ' │            │      30       │ 22, 38                                     │ 20, 21, 23, (24), 37, 39, 40               │'; ...
      ' │            │      36       │ 26, 28, 44, 46                             │ 25, 27, 29, 43, 45, 47                     │'; ...
      ' │            │      42       │ 32, 34, 50, 52                             │ -                                          │'; ...
      ' │            │      48       │ 38, 40, 56, 58                             │ 59                                         │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     2      │      48       | 34, 38, 56, 58, 62, 64                     │ 40, 57, 59                                 │'; ...
      ' │            │      60       │ 50, 52, 68, 70, 74                         │ 48, 49, 51, 56, 64, 69, 71                 │'; ...
      ' │            │      72       │ 62, 64, 70, 82, 86                         │ 61, 63, 68, 76, 81, 83                     │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     3      │      54       │ 44, 64, 66, 68                             │ 42, 43, 65, 67                             │'; ...
      ' │            │      72       │ 56, 58, 62, 82, 84, 86, 88                 │ 57, 59, 60, 61, 83, 85, 87                 │'; ...
      ' │            │      90       │ 74, 76, 78, 80, 100, 102, 104              │ 75, 77, 79, 101, 103, 105                  │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     4      │      48       │ 34, 62                                     │ 35, 61, 63, 65                             │'; ...
      ' │            │      72       │ 58, 86, 88, 90                             │ 56, 57, 59, 85, 87, 89                     │'; ...
      ' │            │      96       │ 78, 82, 110, 112, 114                      │ 79, 80, 81, 83, 109, 111, 113              │'; ...
      ' └────────────┴───────────────┴────────────────────────────────────────────┴────────────────────────────────────────────┘';])

run("T3_Rotor.m");
%------------------------------------------------------------------------------
run("T4_MMF.m");
%------------------------------------------------------------------------------
fprintf("\tp = %d\n", p);
fprintf("\nAlegeti parametrul A conform tabelului : \n")
disp([
'  ┌────────────┬────────┬────────┬────────┬────────┐'; ...
'  │     p      │   1    │   2    │   3    │   4    │'; ...
'  ├────────────┼────────┼────────┼────────┼────────┤'; ...
'  │   A [cm]   │  -4.0  │  -3.5  │   0.0  │  +2.5  │'; ...
'  └────────────┴────────┴────────┴────────┴────────┘';])

fprintf("\nInsert value for: \n")
fprintf("\n\thisc = hd2 + (5 ÷ 10)   [mm]\n\thd2 = %d   [mm]\n", hd2);

run("T5_Windings.m");
%------------------------------------------------------------------------------