disp("===============================================================");
disp("                    ## ME2_Solver Utility ##");
disp("          codet by Crivcianschi Alexei, TUCN, march 2025\n");         
disp("---------------------------------------------------------------"); 
disp("              Starting your script... Please wait!");
disp("===============================================================");



% run with this command from ME2_solver terminal
run(fullfile(pwd, '..', 'lib', 'Init.m'));

% run with this command from Matlab
% run(fullfile(pwd, 'lib', 'Init.m'));

run("T1_Dimensions.m");

run("T2_Stator.m");

run("T3_Rotor.m");