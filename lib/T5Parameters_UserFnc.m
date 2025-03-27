function [A, x, kj] = T5Parameters_UserFnc()
    % Prompts for each parameter
    promt = ["insert value from table for A:"...
             "insert Δ used for h_{isc} = h_{d2} + Δ; Δ = (5 ... 10) [mm]"...
             "insert value for k_{j} from (1.3 ... 1.5)"
            ];

    % Default values for the input dialog
    default_values = {'4', '7', '1.38'};

   
    % Input dialog options (if you want to customize options)
    opts = struct('WindowStyle', 'normal', 'Interpreter', 'tex');
    
    % Input dialog to get user input for each parameter
    answer = inputdlg(promt, "Insert Values for parameters in T2", 1, default_values, opts);
    
    % Convert string answers to numbers
    
    A = str2double(answer{1});
    x = str2double(answer{2});
    kj = str2double(answer{3});


end
