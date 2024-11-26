run("T1_Dimensiuni.mlx")

% ====================================================
% Calculul infasurarilor si crestaturilor statorului
% ====================================================

% Placeholder values from 'CalculDimensiuniPrincipaleT1.mlx' script
m1 = 3;  % numarul de faze

% Numarul de crestaturi ale statorului
% +------------------------------------------------------------+
% |     p    |     1     |     2     |      3     |      4     |
% +----------+-----------+-----------+------------+------------+
% |    q1    |   4 - 8   |   4 - 6   |    3 - 5   |    2 - 4   |
% +------------------------------------------------------------+
q1 = 8;
Z1 = 2 * p * m1 * q1  % Z1 = 48

% Pasul dentar [cm]
t1 = pi * D * 10^-1 / Z1

% Elementele infasurarii statorului [ W ]
Flux = alfai * tau * 10^-3 * lg * 10^-3 * Bdelta

% Coefficient kw1
kw1 = 0.922;  % Assuming kw1 from Annex 1

% Numarul de spire pe faza
w1 = kE * U1 / (4 * kB * f1 * kw1 * Flux)

% a1: 2 * p / a1 ... integer, p = 1 => a1 = {1, 2}
a1 = 2;

if mod(fix((2 * m1 * a1 * w1) / Z1), 2)
    nc1 = fix((2 * m1 * a1 * w1) / Z1) + 1
else
    nc1 = fix((2 * m1 * a1 * w1) / Z1)
end

w1 = Z1*nc1/(6*a1)

% Calculating A
IN = 216.9660;  % Placeholder value for nominal current; replace as needed

% [ A/cm ]
A = (Z1 * nc1 * IN) / (pi * D * 10^-1 * a1)

% Recalculate Flux
Flux = kE * U1 / (4 * kB * f1 * kw1 * w1)

% Inductia maxima in intrefier [T]
Bdelta = Flux / (alfai * tau * lg * 10^-6)

J1 = 5.8;  % [A/mm^2]
Scu1 = IN / (a1 * J1) % [ mm^2 ]

nf = 10;
ntot = nf * nc1
dc = sqrt(4 * Scu1 / (pi * nf))
dc = 1.55

Scond = pi * dc^2 / 4

Scu1 = 10 * Scond

iz = 0.04;
dci = dc + 2 * iz

kFe = 0.95;
Bd1 = 1.7;
bd1 = 10 * t1 * Bdelta / (kFe * Bd1) %  [mm]

ku = 0.75;
Scr = ntot * dci^2 / ku % [mm^2]


bistm1 = 3.25 % [mm]

histm1 = 1.8; % [mm]
hpana = 3; % [mm]
giz = 0.4; % [mm]

% [mm]
bcr1v = (D + 2 * histm1 + 2 * hpana + 4 * giz) * pi / Z1 - bd1

hutilcr1 = (sqrt((bcr1v - 2 * giz)^2 + 4 * Scr * tan(pi / Z1)) - bcr1v + 2 * giz) / (2 * tan(pi / Z1))

hd1 = hutilcr1 + histm1 + hpana + 4 * giz
% hd1 = 51.13

bcr1b = (D + 2 * hd1) * pi / Z1 - bd1

bd1v = (D + 2 * histm1 + 2 * hpana) * pi / Z1 - bcr1v
bd1b = (D + 2 * hd1)* pi / Z1 - bcr1b

hj1 = (De - D) / 2 - hd1

% Bj1 = 1.3 ... 1.6
Bj1 = Flux / (2 * kFe * lg * hj1 * 10^-6)

% [mm^2]
Scr1util = 0.5*((bcr1v - 2*giz)+(bcr1b - 2*giz))*(hd1-histm1-hpana-2*giz) % [mm^2]
