% Import variables from the respective scripts
% Assuming f1, Un, n, Pn are defined in Variables.m
% and Un, n, Pn, p, etaN, cosFiN, U1, Sn, I1n, kE, E1, Sin, kw, ksd, alfai, kB, C, lambda_, D, kD, De, tau, A, Bdelta, lg, delta are defined in T1.m

run("CalculDimensiuniPrincipaleT1.mlx")

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
q1 = 5;
Z1 = 2 * p * m1 * q1;  % Z1 = 24

% Pasul dentar [cm]
t1 = pi * D / Z1;

% Elementele infasurarii statorului
Flux = alfai * tau * lg * Bdelta / 10^4;

% Coefficient kw1
kw1 = 0.94;  % Assuming kw1 from Annex 1

% Numarul de spire pe faza
w1 = kE * U1 / (4 * kB * f1 * kw1 * Flux);
w1 = 30;

% a1: 2 * p / a1 ... integer, p = 1 => a1 = {1, 2}
a1 = 2;
nc1 = (2 * m1 * a1 * w1) / Z1;

% Calculating A
IN = 216.9660;  % Placeholder value for nominal current; replace as needed
A = (Z1 * nc1 * IN) / (pi * D * a1);

% Recalculate Flux
Flux = kE * U1 / (4 * kB * f1 * kw1 * w1);

% Inductia maxima in intrefier [T]
Bdelta = Flux / (alfai * tau * lg * 10e-4);

J1 = 5.8;  % [A/mm^2]
Scu1 = IN / (a1 * J1);

nf = 10;
ntot = 120;
dc = sqrt(4 * Scu1 / (pi * nf));
dc = 1.55;

Scond = pi * dc^2 / 4;

Scu1 = 10 * Scond;

iz = 0.04;
dci = dc + 2 * iz;

kFe = 0.95;
Bd1 = 1.6;
bd1 = 1.225;  % [cm]

ku = 0.7;
Scr = ntot * dci^2 / ku;

Scr = 280;

histm1 = 3.15;
histm11 = 1.5;
hpana = 2.5;
giz = 0.35;

bcr1v = (D + 2 * histm11 + 2 * hpana + 4 * giz) * pi / Z1 - bd1;

hutilcr1 = (sqrt((bcr1v - 2 * giz)^2 + 4 * Scr * tan(pi / Z1)) - bcr1v + 2 * giz) / (2 * tan(pi / Z1));

hd1 = hutilcr1 + histm1 + hpana + 4 * giz;
hd1 = 22.06;  % [mm]

bcr1h = (D + 2 * hd1) * pi / Z1 - bd1;

hd1v = (D + 2 * histm1 + 2 * hpana) * pi / Z1 - bcr1v;

hj1 = (De - D) * 5 - hd1;

Bj1 = Flux / (2 * kFe * lg * hj1 * 0.00001);
