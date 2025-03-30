function [A, x, kj] = T5Parameters_UserFnc(p)
    % Prompts for each parameter
    promt = ["insert value from table for A:"...
             "insert Δ used for h_{isc} = h_{d2} + Δ; Δ = (5 ... 10) [mm]"...
             "insert value for k_{j} from (1.3 ... 1.5)"
            ];

    % Default values for the input dialog
    default_values = {'4', '7', '1.38'};

%   ┌────────────┬────────┬────────┬────────┬────────┐
%   │     p      │   1    │   2    │   3    │   4    │
%   ├────────────┼────────┼────────┼────────┼────────┤
%   │   A [cm]   │  -4.0  │  -3.5  │   0.0  │  +2.5  │
%   └────────────┴────────┴────────┴────────┴────────┘
 
    switch p
        case 1
            default_values = {'4', '7', '1.38'};
        case 2
            default_values = {'3.5', '7', '1.38'};
        case 3
            default_values = {'0', '7', '1.38'};
        case 4
            default_values = {'2.5', '7', '1.38'};
        otherwise
            disp("[ ERROR ] p out of range! Check initial values.")
            return;
    end
   
    % Input dialog options (if you want to customize options)
    opts = struct('WindowStyle', 'normal', 'Interpreter', 'tex');
    
    % Input dialog to get user input for each parameter
    answer = inputdlg(promt, "Insert Values for parameters in T2", 1, default_values, opts);
    
    % Convert string answers to numbers
    
    A = str2double(answer{1});
    x = str2double(answer{2});
    kj = str2double(answer{3});

end
