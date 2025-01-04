run("T2_Stator.mlx");
% ==========================================
%       Calculul Infasurarii induse
% ==========================================

Z2 = 56;
m2 = Z2;

alpha = (2 * pi * p) / Z2

%pasul dentar al rotorului [ mm ]
Dr = D - 2 * delta;
t2 = (pi * (D - 2 * delta)) / Z2

ki = sin(pi/Z1) / (pi/Z1)

% Dimensionarea crestaturii rotorului
config = "DREPTE";

if config == "DREPTE"
    w2 = 0.5
    kw2 = 1
else
    w2 = 0.5
    kw2 = ki
end

% t.e.m. pe faza 
E2 = kE * U1 * (w2 * kw2) / (w1 * kw1)
U20 = E2;

% curentul pe faza
kI = 0.93;
I2 = (m1 * w1 * kw1 * kI * IN) / (m2 * w2 * kw2)
I2N = I2;
if config == "DREPTE"
    Ib = kI * IN * (2 * m1 * w1 * kw1) / Z2
else
    Ib = kI * IN * (2 * m1 * w1 * kw1) / (Z2 * ki)
end
% curentul in inelul de scurt circuit:
Ii = Ib / (2 * sin(pi * p / Z2))

J2b = 3.6; % [A/mm^2]
J2i = 0.72 * J2b;
% sectiunea barei: [ mm^2 ]
sb = Ib / J2b
% sectiunea ineluljui de scurt-circuitare: [mm^2]
si = Ii / J2i

% latimea constanta a dintelui rotoric:
kFe = 0.95;
% Bd2 = 1.5 ... 1.8 [T]
Bd2 = 1.65
bd2 = (t2 * Bdelta) / (kFe * Bd2)

bistm2 = 1.8; % bistm2 = 1 ... 1.5 mm
histm2 = 1.2; % histm2 = 0.8 ... 1.5 mm

% latimea crestaturii barei rotorice: [mm]
bcr2v = (pi / Z2) * (Dr - 2 * histm2) - bd2
% inaltimea crestaturii rotorice: [mm]
hcr2 = (Z2 / (2 * pi)) * (bcr2v - sqrt(bcr2v^2 - (4 * pi / Z2) * sb)) + histm2
hd2 = hcr2; % [mm]
% latimea crestaturii rotorice:
bcr2b = bcr2v - (2 * pi / Z2) * (hcr2 - histm2)
% latimea dintelui rotoric la varfului crestaturii trapezoidale:
bd2v = (pi / Z2) * (Dr - 2 * histm2) - bcr2v
% latimea dintelui rotoric la baza crestaturii:
bd2b =  (pi / Z2) * (Dr - 2 * hd2) - bcr2b
% aria sectiunii nete a crestaturii rotorice:
sb = ((bcr2v + bcr2b) / 2) * (hcr2 - histm2)


lFe = lg;
Bj2 = 1.3;
hj2 = Flux / (2 * kFe * lFe * Bj2 * 10^-6)
Dir = Dr - 2 * (hd2 + hj2) % [mm]
