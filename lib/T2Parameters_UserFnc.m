function [q1, a1, J1, iz, kw1, Bd1, ku] = T2Parameters_UserFnc(p)
    % Prompts for each parameter
    promt = ["give value for: q_{1} = "...
             "give value for: a_{1} = "...
             "give value for J1 "...
             "give value for i_{z}"...
             "give value for k_{w1} "...
             "give value for B_{d1} "...
             "give value for k_{u} "
             ];

    % Default values for the input dialog
    default_values = {'8', '2', '5.8', '0.04', '0.922', '1.7', '0.75'};

    % Numarul de crestaturi ale statorului
    % ┌─────────┬─────────┬─────────┬─────────┬─────────┐
    % │    p    │    1    │    2    │    3    │    4    │
    % ├─────────┼─────────┼─────────┼─────────┼─────────┤
    % │   q₁    │  4 - 8  │  4 - 6  │  3 - 5  │  2 - 4  │
    % └─────────┴─────────┴─────────┴─────────┴─────────┘

    % Modify prompts based on the value of p
    switch p
        case 1
            promt(1) = promt(1) + "4 ... 8";
            promt(2) = promt(2) + "2";
        case 2
            promt(1) = promt(1) + "4 ... 6";
            promt(2) = promt(2) + "4";
        case 3
            promt(1) = promt(1) + "3 ... 5";
            promt(2) = promt(2) + "6";
        case 4
            promt(1) = promt(1) + + "2 ... 4";
            promt(2) = promt(2) + "8";
        otherwise
            disp("[ ERROR ] p out of range! Check initial values.")
            return;
    end
   
    % Input dialog options (if you want to customize options)
    opts = struct('WindowStyle', 'normal', 'Interpreter', 'tex');
    
    % Input dialog to get user input for each parameter
    answer = inputdlg(promt, "Insert Values for parameters in T2", 1, default_values, opts);
    
    % Convert string answers to numbers
    q1 = str2double(answer{1});
    a1 = str2double(answer{2});
    J1 = str2double(answer{3});
    iz = str2double(answer{4});
    kw1 = str2double(answer{5});
    Bd1 = str2double(answer{6});
    ku = str2double(answer{7});

end
