% =======================================================================
if ~exist('start_method', 'var')
    DefaultPath = 'C:\Users\SZ\Desktop\Facultate FIE\facultate an III\an III sem. 1\ME2_Solver';

    HomeDirectory = inputdlg("Give the actual Project Directory", ...
        "Give the actual Project Directory", [1, 75], {DefaultPath});
end
%-----------------------------------------------------------------------
HomeDirectory = string(HomeDirectory);
cd(HomeDirectory);

addpath(genpath(fullfile(pwd, 'lib')));
addpath(genpath(fullfile(pwd, 'src')));
% -----------------------------------------------------------------------
% Interpolations intitialization :
Table = fullfile(HomeDirectory, 'data', 'ME2_Graphs.xlsx');
clear("DefaultPath");

% -----------------------------------------------------------------------
run("HeaderScript.m");
% -----------------------------------------------------------------------
% Table ranges
% -----------------------------------------------------------------------
fig2_1_range = 'B14:F30';
fig2_2_range = 'H14:L32';
fig2_4_range = 'N14:P25';
fig2_5_range = 'R14:V44';
fig2_6_range = 'X14:AB53';
fig2_7_range = 'AD14:AH32';
fig2_8_range = 'AJ14:AN40';
% -----------------------------------------------------------------------
fig3_1_range = 'B11:C200';
% -----------------------------------------------------------------------
fig6_1_range = 'B3:C99';
% -----------------------------------------------------------------------
fig4_range = 'B2:C11'; 


