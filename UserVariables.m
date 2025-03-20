%========================================================================
function [kw, ksd, lambda, kD] = UserVariables(p, Kw_default, Ksd_default, lambda_default, kD_default)
    switch p
        case 1
            lambda_range = "0.35 ... 1.25";
            kD_range = "1.65 ... 1.69";
        case 2
            lambda_range = "0.5 ... 1.75";
            kD_range = "1.46 ... 1.49";
        case 3
            lambda_range = "0.65 ... 1.90";
            kD_range = "1.37 ... 1.40";
        case 4
            lambda_range = "0.75 ... 2.2";
            kD_range = "1.27 ... 1.30";
        otherwise
            disp("[ ERROR ] p out of range! Check initial values.")
    end
end