% -----------------------------------------------------------------------
run("HeaderScript.m");
run("TableMap.m");
run("popUpMessages.m");
% -----------------------------------------------------------------------
DefaultPath = 'C:\Users\SZ\Desktop\Facultate FIE\facultate an III\an III sem. 1\ME2_Solver';

HomeDirectory = inputdlg("Give the actual Project Directory", ...
    "Give the actual Project Directory", [1, 75], {DefaultPath}, opts);
%-----------------------------------------------------------------------
HomeDirectory = string(HomeDirectory);
cd(HomeDirectory);
% -----------------------------------------------------------------------
% Interpolations intitialization :
Table = fullfile(HomeDirectory, 'data', 'ME2_Graphs.xlsx');
clear("HomeDirectory", "DefaultPath");



