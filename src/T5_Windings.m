run("T4_TMM.mlx");
%----------------------------------------
Z = [Z1, Z2];
ytau = Z ./ (2*p) ;

t1 = t1*10 % [mm]
y1 = ytau(1)*5/6 % y1 = Z1*5/6

hcr1 = hd1;  % [mm]
hcr2 = hd2;  % [mm]

tmed = pi * (D + hcr1) / Z1 % [mm]
Rm = y1 * tmed / 2 % [mm]
%----------------------------------------

%            Date tabelare (Tabelul 5.1)
% +----------+--------+--------+--------+--------+
% |     p    |    1   |    2   |    3   |    4   |   
% +----------+--------+--------+--------+--------+
% |  A [cm]  |  -4.0  |  -3.5  |   0.0  |  +2.5  |
% +----------+--------+--------+--------+--------+

A = 4;
lf1 = (pi*Rm/10) - (2*A) % [cm]
lwmed1 = lg/10 + lf1 % [cm]

ro20 = 1 / 56;  % [Ohm*mm^2/m]
ro115 = 1.38 * ro20; % [Ohm*mm^2/m]
ro_teta = ro115

L1 = 2 * w1 * lwmed1/100 % [m]
R1 = ro_teta * L1 / (a1 * Scu1)

%----------------------------------------
Lb = lg % [mm]
hisc = hd2 + 7  % hisc = hd2 + (5 ÷ 10)   [mm]
ro115 = 0.043125; % [Ohm*mm^2/m]
Disc = Dr - hisc

Li = pi * Disc / Z2 % [mm]

Rb = ro115 * Lb * 10^-3 / sb
Ri = ro115 * Li * 10^-3 / si

bisc = si/hisc % [mm]

bcr1m = sqrt(0.5*(bcr1v^2 + bcr1b^2)) % [mm]
hcr1v = ((bcr1m - bcr1v) / (bcr1b - bcr1v)) * (hcr1 - histm1 - hpana - 4 * giz) % [mm]
hcr1b = ((bcr1b - bcr1m) / (bcr1b - bcr1v)) * (hcr1 - histm1 - hpana - 4 * giz) % [mm]

Kcu = 1.67 + 6*p*y1/Z1;
Kh = 1.00 + 6*p*y1/Z1;

lambda_cr1 = 0.25 * ((2/3) * (hcr1b / (bcr1b + bcr1m)) + (giz / bcr1m) + ...
    Kcu * (hcr1v / (bcr1m + bcr1v))) + 0.25 * Kh * ...
    ((hpana + 2 * giz) / bcr1v + (2 * hpana / (bcr1v + bistm1)) + (histm1 / bistm1))

lambda_d1 = t1*kw1^2 / (11.9 * kC * delta)
lambda_f1 = 0.34 * q1 * (lf1*10 - 0.064 * tau) / lg
% [Ohm]
X_sigma1 = 0.158 * f1 * w1^2 * (lg / (10 * p * q1)) * 10^-6 * (lambda_cr1 + lambda_d1 + lambda_f1) % [Ohm]

bcr2 = 0.5 * (bcr2v + bcr2b);
lambda_cr2 = (hcr2 - histm2)/(3 * bcr2) + histm2/bistm2

lambda_d2 = 0.084034 * t2 / (kC * delta)

lambda_f2 = 2.3 * Disc * log(4.7 * Disc / (hisc + 2*bisc)) ...
    / (4 * Z2 * lg * (sin(pi* p / Z2))^2 )

% [Ohm]
X_sigma2 = 7.9 * f1 * lg * 10^-9 * (lambda_cr2 + lambda_d2 + lambda_f2)

Xm = (U1 - Imiu * X_sigma1) / Imiu
K = 12 * (w1 * kw1)^2 / Z2 % [Ohm]
R2 = Rb + Ri / (2 * (sin(pi * p / Z2))^2); % [Ohm]
R2_ = K * R2; % [Ohm]
