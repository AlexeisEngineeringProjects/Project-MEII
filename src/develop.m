% opts.Interpreter = 'tex';
% opts.WindowStyle = 'normal';
% ksd_ = inputdlg("K_{sd}", "Input Ksd", [1, 60], {'0'}, opts);
% ksd = str2double(ksd_{1});
% clear("ksd_", "opts")
% run("lib\Init.m")
% cd("C:\Users\SZ\Desktop\Facultate FIE\facultate an III\an III sem. 1\ME2_Solver");
% Homedirecotry = pwd;
% 
% addpath(genpath('src'));  % Add all scripts from src/
% addpath(genpath('lib'));  % Add all helper functions
% 
% fig2_4 = readtable(Table, ...
%     Sheet = "T1", Range = fig2_4_range);
% 
% X = fig2_4.ksd; 
% Y = fig2_4.alpfai;
% 
% Kbfunct = Interpolation_Fnct(X, Y);
% disp(Kbfunct(1.28));
% 
% 
% 
