disp("");
disp("running...");
disp("");

% ============================================================
%              Calculul Puterii Aparente interne
% ============================================================
%            Date tabelare (Tabelul 2.1)
% ┌─────────┬─────────┬─────────┬─────────┬─────────┐
% │    p    │    4    │    3    │    2    │    1    │
% ├─────────┼─────────┼─────────┼─────────┼─────────┤
% │   n₁    │   750   │  1000   │  1500   │  3000   │
% └─────────┴─────────┴─────────┴─────────┴─────────┘

pTabel = [4, 3, 2, 1];
n1Tabel = [750, 1000, 1500, 3000]; 
p = NaN; 

if n >= n1Tabel(end)
    p = p(end);
    disp("[ ERROR ] n out of range. Check initial values!");
end

for i = 1:length(n1Tabel) - 1
    if n < n1Tabel(1)
        p = pTabel(1);
        break;
    end

    if n1Tabel(i) <= n && n < n1Tabel(i+1)
        p = pTabel(i+1);
        break;
    end
end

if isnan(p)
    disp("[ ERROR ] p was not defined in previous loop.");
end
clear("pTabel", "n1Tabel", "i");
%----------------------------------------------------------------------
[kw, ksd, lambda, kD] = T1Parameters_UserFnc(p);
%----------------------------------------------------------------------
fig2_1 = readtable(Table, ...
    Sheet = "T1", Range = fig2_1_range);
X = fig2_1.P;

switch p
    case 1
        Y = fig2_1.randp1;
    case 2
        Y = fig2_1.randp2;
    case 3
        Y = fig2_1.randp3;
    case 4
        Y = fig2_1.randp4;
    otherwise
        disp("[ ERROR ] p out of range! Check initial values.")
end

Rand_ = Interpolation_Fnct(X, Y);
etaN = Rand_(Pn); % Randamentul nominal
clear("Rand_", "fig2_1", "fig2_1_range");
%----------------------------------------------------------------------
fig2_2 = readtable(Table, ...
    Sheet = "T1", Range = fig2_2_range);
X = fig2_2.P;

switch p
    case 1
        Y = fig2_2.cosFp1;
    case 2
        Y = fig2_2.cosFp2;
    case 3
        Y = fig2_2.cosFp3;
    case 4
        Y = fig2_2.cosFp4;
    otherwise
        disp("[ ERROR ] p out of range! Check initial values.")
end

PowerFactor = Interpolation_Fnct(X, Y);
cosFiN = PowerFactor(Pn); % Randamentul nominal
clear("PowerFactor", "fig2_2", "fig2_2_range");
%----------------------------------------------------------------------
% Calculați U1, Sn și I1n
U1 = Un / sqrt(3); % [V]
Sn = Pn / (etaN * cosFiN); % [VA]
I1n = Sn / (3 * U1); % [A]
IN = I1n;
% Tensiunea electromotoare pe fază și puterea aparentă internă
kE = 0.98 - p * 5e-3; % [-]
E1 = kE * U1; % EMF [V]
Sin = 3 * E1 * I1n; % [VA]
%----------------------------------------------------------------------
fig2_4 = readtable(Table, ...
    Sheet = "T1", Range = fig2_4_range);

X = fig2_4.ksd; 
Y = fig2_4.alpfai;

alpha_funct = Interpolation_Fnct(X, Y);
alfai = alpha_funct(ksd);
clear("alpha_funct")

Y = fig2_4.kB;

KB_funct = Interpolation_Fnct(X, Y);
kB = KB_funct(ksd); 

clear("KB_funct", "fig2_4", "fig2_4_range");

% ============================================================
%               Calculul dimensiunilor principale
% ============================================================

fig2_5 = readtable(Table, ...
    Sheet = "T1", Range = fig2_5_range);

X = fig2_5.SiN;

switch p
    case 1
        Y = fig2_5.Cp1;
    case 2
        Y = fig2_5.Cp2;
    case 3
        Y = fig2_5.Cp3;
    case 4
        Y = fig2_5.Cp4;
    otherwise
        disp("[ ERROR ] p out of range! Check initial values.")
end

C_funct = Interpolation_Fnct(X, Y);
C = C_funct(Sin * 0.001); % in table SiN in in [kVA]

clear("C_funct", "fig2_5", "fig2_5_range");
%----------------------------------------------------------------------
D = 10 * fix(23.32 * (p^2 * Sin / (1000 * lambda * C))^(1/3)) + 1; % Diametrul interior al statorului [mm]

%----------------------------------------------------------------------
De = kD * D; % Diametrul exterior al statorului [mm]
tau = pi * D / (2 * p); % Lungimea pasului polar [mm]
%----------------------------------------------------------------------
fig2_7 = readtable(Table, ...
    Sheet = "T1", Range = fig2_7_range);

X = fig2_7.pas_polar;
switch p
    case 1
        Y = fig2_7.Ap1;
    case 2
        Y = fig2_7.Ap2;
    case 3
        Y = fig2_7.Ap3;
    case 4
        Y = fig2_7.Ap4;
    otherwise
        disp("[ ERROR ] p out of range! Check initial values.")
end

A_funct = Interpolation_Fnct(X, Y);
A = A_funct(tau * 0.1); % in table tau is [cm]
clear("A_funct", "fig2_7", "fig2_7_range"); % [A/cm] % A = 472
%----------------------------------------------------------------------
fig2_8 = readtable(Table, ...
    Sheet = "T1", Range = fig2_8_range);

X = fig2_8.pas_polar;
switch p
    case 1
        Y = fig2_8.Bdelta_p1;
    case 2
        Y = fig2_8.Bdelta_p2;
    case 3
        Y = fig2_8.Bdelta_p3;
    case 4
        Y = fig2_8.Bdelta_p4;
    otherwise
        disp("[ ERROR ] p out of range! Check initial values.")
end

B_funct = Interpolation_Fnct(X, Y);
Bdelta = B_funct(tau * 0.1); % in table tau is [cm] % Bdelta = 0.675 [T]
clear("B_funct", "fig2_8", "fig2_8_range");

%----------------------------------------------------------------------
lg = (2 * p * Sin * 1e7) / (1000 * kB * kw * alfai * D^2 * A * Bdelta); % Lungimea geometrica [mm]

delta = 0.03 * (4 + 0.7 * sqrt(D * lg * 10^-2)); % Lungimea intrefierului [mm]
% delta = 0.6; % recomandat 0.60 mm

fprintf("[ PASS ] T1 Script finished succesfully!\n");