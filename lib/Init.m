% -----------------------------------------------------------------------
run("HeaderScript.m");
run("TableMap.m");
% run("popUpMessages.m");

% =======================================================================
% The next functionality was implemented and optimized in ME2_Solver.bat script

% run without this section from ME2_Solver terminal:
% 
% DefaultPath = 'C:\Users\SZ\Desktop\Facultate FIE\facultate an III\an III sem. 1\ME2_Solver';
% 
% HomeDirectory = inputdlg("Give the actual Project Directory", ...
%     "Give the actual Project Directory", [1, 75], {DefaultPath}, opts);

%-----------------------------------------------------------------------
HomeDirectory = string(HomeDirectory);
cd(HomeDirectory);

addpath(genpath(fullfile(pwd, 'lib')));
addpath(genpath(fullfile(pwd, 'src')));
% -----------------------------------------------------------------------
% Interpolations intitialization :
Table = fullfile(HomeDirectory, 'data', 'ME2_Graphs.xlsx');
clear("DefaultPath");



