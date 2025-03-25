function [Z2, config, J2b, Bd2, Bj2] = T3Parameters_UserFnc()
    % Prompts for each parameter
    promt = ["insert Z2 from table: "...
             "specify configuration: "...
             "insert J_{2b} from (3 ... 4.5) [A/mm^{2}]"...
             "insert B_{d2} from (1.5 ... 1.8) [T]"...
             "insert B_{d2} from (1.2 ... 1.6) [T]"
             ];

    % Default values for the input dialog
    default_values = {'56', 'DREPTE', '3.6', '1.65', '1.3'};

   
    % Input dialog options (if you want to customize options)
    opts = struct('WindowStyle', 'normal', 'Interpreter', 'tex');
    
    % Input dialog to get user input for each parameter
    answer = inputdlg(promt, "Insert Values for parameters in T2", 1, default_values, opts);
    
    % Convert string answers to numbers
    
    Z2 = str2double(answer{1});
    config = string(answer{2});
    J2b = str2double(answer{3});
    Bd2 = str2double(answer{4});
    Bj2 = str2double(answer{5});
end
