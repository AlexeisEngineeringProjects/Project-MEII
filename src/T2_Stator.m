% ====================================================
% Calculul infasurarilor si crestaturilor statorului
% ====================================================

m1 = 3;  % numarul de faze
%----------------------------------------------------------------------
[q1, a1, J1, iz, kw1, Bd1, ku, bistm1, histm1, hpana, giz] = T2Parameters_UserFnc(p); 
kFe = 0.95;
%----------------------------------------------------------------------

Z1 = 2 * p * m1 * q1;  % Z1 = 48
t1 = pi * D * 10^-1 / Z1; % [cm]
Flux = alfai * tau * 10^-3 * lg * 10^-3 * Bdelta; % [Wb]

% Numarul de spire pe faza
w1 = kE * U1 / (4 * kB * f1 * kw1 * Flux);
%----------------------------------------------------------------------
if mod(fix((2 * m1 * a1 * w1) / Z1), 2)
    nc1 = fix((2 * m1 * a1 * w1) / Z1) + 1;
else
    nc1 = fix((2 * m1 * a1 * w1) / Z1);
end
%----------------------------------------------------------------------
w1 = Z1*nc1/(6*a1);

IN = I1n;  % [A]
A = (Z1 * nc1 * IN) / (pi * D * 10^-1 * a1); % [A/cm]
Flux = kE * U1 / (4 * kB * f1 * kw1 * w1); % [Wb]

% Inductia maxima in intrefier [T]
Bdelta = Flux / (alfai * tau * lg * 10^-6); % [T]
%----------------------------------------------------------------------
Scu1 = IN / (a1 * J1); % [ mm^2 ]
%----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nf = 10; % ???
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------
ntot = nf * nc1;
dc = sqrt(4 * Scu1 / (pi * nf));

Scond = pi * dc^2 / 4;

Scu1 = 10 * Scond;
%----------------------------------------------------------------------
dci = dc + 2 * iz;
bd1 = 10 * t1 * Bdelta / (kFe * Bd1); %  [mm]

Scr = ntot * dci^2 / ku; % [mm^2]
%----------------------------------------------------------------------
bcr1v = (D + 2 * histm1 + 2 * hpana + 4 * giz) * pi / Z1 - bd1; % [mm]

hutilcr1 = (sqrt((bcr1v - 2 * giz)^2 + 4 * Scr * tan(pi / Z1)) - bcr1v + 2 * giz) / (2 * tan(pi / Z1));

hd1 = hutilcr1 + histm1 + hpana + 4 * giz;

bcr1b = (D + 2 * hd1) * pi / Z1 - bd1;

bd1v = (D + 2 * histm1 + 2 * hpana) * pi / Z1 - bcr1v;

bd1b = (D + 2 * hd1)* pi / Z1 - bcr1b;

hj1 = (De - D) / 2 - hd1;

% Bj1 = 1.3 ... 1.6 [T]
Bj1 = Flux / (2 * kFe * lg * hj1 * 10^-6); % [T]

% [mm^2]
Scr1util = 0.5*((bcr1v - 2*giz)+(bcr1b - 2*giz))*(hd1-histm1-hpana-2*giz); % [mm^2]

fprintf("[ PASS ] T2 Script finished succesfully!\n");
