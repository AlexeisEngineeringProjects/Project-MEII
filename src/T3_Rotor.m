% ==========================================
%       Calculul Infasurarii induse
% ==========================================

% ==========================================
fprintf(" p = %d\n", p);
fprintf(" Z1 = %d\n", Z1);
disp("alegeti Z2 conform tabelului:")

disp([' ┌────────────┬───────────────┬────────────────────────────────────────────┬────────────────────────────────────────────┐'; ...
      ' │ Nr. perechi│  crestaturi   │           Nr. crestaturi DREPTE            │           Nr. crestaturi ÎNCLINATE         │'; ...
      ' │   poli p   │   stator Z1   │             ale rotorului Z2               │               ale rotorului Z2             |'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     1      │      24       │ 32                                         │ 31, 33, 34, 35                             │'; ...
      ' │            │      30       │ 22, 38                                     │ 20, 21, 23, (24), 37, 39, 40               │'; ...
      ' │            │      36       │ 26, 28, 44, 46                             │ 25, 27, 29, 43, 45, 47                     │'; ...
      ' │            │      42       │ 32, 34, 50, 52                             │ -                                          │'; ...
      ' │            │      48       │ 38, 40, 56, 58                             │ 59                                         │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     2      │      48       │ 34, 38, 56, 58, 62, 64                     │ 40, 57, 59                                 │'; ...
      ' │            │      60       │ 50, 52, 68, 70, 74                         │ 48, 49, 51, 56, 64, 69, 71                 │'; ...
      ' │            │      72       │ 62, 64, 70, 82, 86                         │ 61, 63, 68, 76, 81, 83                     │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     3      │      54       │ 44, 64, 66, 68                             │ 42, 43, 65, 67                             │'; ...
      ' │            │      72       │ 56, 58, 62, 82, 84, 86, 88                 │ 57, 59, 60, 61, 83, 85, 87                 │'; ...
      ' │            │      90       │ 74, 76, 78, 80, 100, 102, 104              │ 75, 77, 79, 101, 103, 105                  │'; ...
      ' ├────────────┼───────────────┼────────────────────────────────────────────┼────────────────────────────────────────────┤'; ...
      ' │     4      │      48       │ 34, 62                                     │ 35, 61, 63, 65                             │'; ...
      ' │            │      72       │ 58, 86, 88, 90                             │ 56, 57, 59, 85, 87, 89                     │'; ...
      ' │            │      96       │ 78, 82, 110, 112, 114                      │ 79, 80, 81, 83, 109, 111, 113              │'; ...
      ' └────────────┴───────────────┴────────────────────────────────────────────┴────────────────────────────────────────────┘'])

[Z2, config, J2b, Bd2, Bj2] = T3Parameters_UserFnc();
% ==========================================

m2 = Z2;

alpha = (2 * pi * p) / Z2;

%pasul dentar al rotorului [ mm ]
Dr = D - 2 * delta;
t2 = (pi * (D - 2 * delta)) / Z2;

ki = sin(pi/Z1) / (pi/Z1);

% Dimensionarea crestaturii rotorului
if config == "DREPTE" || config == "drepte"
    w2 = 0.5;
    kw2 = 1;
else
    w2 = 0.5;
    kw2 = ki;
end

% t.e.m. pe faza 
E2 = kE * U1 * (w2 * kw2) / (w1 * kw1);
U20 = E2;

% curentul pe faza
% ==========================================
kI = 0.93;
% ==========================================

I2 = (m1 * w1 * kw1 * kI * IN) / (m2 * w2 * kw2);
I2N = I2;

if config == "DREPTE" || config == "drepte"
    Ib = kI * IN * (2 * m1 * w1 * kw1) / Z2;
else
    Ib = kI * IN * (2 * m1 * w1 * kw1) / (Z2 * ki);
end
% curentul in inelul de scurt circuit:
Ii = Ib / (2 * sin(pi * p / Z2));

% J2b = 3.6; % [A/mm^2]  sealege intre 3 ... 4.5
J2i = 0.72 * J2b;
% sectiunea barei: [ mm^2 ]
sb = Ib / J2b;
% sectiunea ineluljui de scurt-circuitare: [mm^2]
si = Ii / J2i;

% latimea constanta a dintelui rotoric:
kFe = 0.95;

% Bd2 = 1.65; % Bd2 = 1.5 ... 1.8 [T]

bd2 = (t2 * Bdelta) / (kFe * Bd2);

bistm2 = 1.8; % bistm2 = 1 ... 2 mm
histm2 = 1.2; % histm2 = 0.8 ... 1.5 mm

% latimea crestaturii barei rotorice: [mm]
bcr2v = (pi / Z2) * (Dr - 2 * histm2) - bd2;
% inaltimea crestaturii rotorice: [mm]
hcr2 = (Z2 / (2 * pi)) * (bcr2v - sqrt(bcr2v^2 - (4 * pi / Z2) * sb)) + histm2;
hd2 = hcr2; % [mm]
% latimea crestaturii rotorice:
bcr2b = bcr2v - (2 * pi / Z2) * (hcr2 - histm2);
% latimea dintelui rotoric la varfului crestaturii trapezoidale:
bd2v = (pi / Z2) * (Dr - 2 * histm2) - bcr2v;
% latimea dintelui rotoric la baza crestaturii:
bd2b =  (pi / Z2) * (Dr - 2 * hd2) - bcr2b;
% aria sectiunii nete a crestaturii rotorice:
sb = ((bcr2v + bcr2b) / 2) * (hcr2 - histm2);


lFe = lg;
% Bj2 = 1.3; % se alege intre 1.2 ... 1.6 [T] 
hj2 = Flux / (2 * kFe * lFe * Bj2 * 10^-6);
Dir = Dr - 2 * (hd2 + hj2); % [mm]
