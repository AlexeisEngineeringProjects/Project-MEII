function [kw, ksd, lambda, kD] = T1Parameters_UserFnc(p)
    % Prompts for each parameter
    promt = ['give value for: K_{w} = 0.91 ... 0.93'...
             'give value for: K_{sd} = 1.2 ... 1.35'...
             "give value for: lambda = "...
             "give value for: K_{D} = "];
    
    %                   Date tabelare (Tabelul 2.2)
    % ┌─────────┬────────────┬────────────┬────────────┬────────────┐
    % │    p    │     1      │     2      │     3      │     4      │
    % ├─────────┼────────────┼────────────┼────────────┼────────────┤
    % │  lambda │  0.35-1.25 │  0.5-1.75  │  0.65-1.9  │  0.75-2.2  │
    % └─────────┴────────────┴────────────┴────────────┴────────────┘
    %----------------------------------------------------------------------
    %                  Date tabelare (Tabelul 2.3)
    % ┌─────────┬────────────┬────────────┬────────────┬────────────┐
    % │    p    │     1      │     2      │     3      │     4      │
    % ├─────────┼────────────┼────────────┼────────────┼────────────┤
    % │   kD    │  1.65-1.69 │  1.46-1.49 │  1.37-1.4  │  1.27-1.3  │
    % └─────────┴────────────┴────────────┴────────────┴────────────┘

    % Modify prompts based on the value of p
    switch p
        case 1
            promt(3) = promt(3) + "0.35 ... 1.25";
            promt(4) = promt(4) + "1.65 ... 1.69";
        case 2
            promt(3) = promt(3) + "0.5 ... 1.75";
            promt(4) = promt(4) + "1.46 ... 1.49";
        case 3
            promt(3) = promt(3) + "0.65 ... 1.90";
            promt(4) = promt(4) + "1.37 ... 1.40";
        case 4
            promt(3) = promt(3) + "0.75 ... 2.2";
            promt(4) = promt(4) + "1.27 ... 1.30";
        otherwise
            disp("[ ERROR ] p out of range! Check initial values.")
            return;
    end
    
    % Default values for the input dialog
    default_values = {'0.92', '1.28', '0.37', '1.66'};
    
    % Input dialog options (if you want to customize options)
    opts = struct('WindowStyle', 'normal', 'Interpreter', 'tex');
    
    % Input dialog to get user input for each parameter
    answer = inputdlg(promt, 'Insert Vales for parameters in T1', 1, default_values, opts);
    
    % Convert string answers to numbers
    kw = str2double(answer{1});
    ksd = str2double(answer{2});
    lambda = str2double(answer{3});
    kD = str2double(answer{4});
end
