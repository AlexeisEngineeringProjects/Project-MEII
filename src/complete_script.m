run("lib\HeaderScript.m")
%===========================[STEP 1]=================================
%               Data (Tab. 2.1)
% ┌─────────┬─────────┬─────────┬─────────┬─────────┐
% │    p    │    1    │    2    │    3    │    4    │
% ├─────────┼─────────┼─────────┼─────────┼─────────┤
% │   n₁    │  3000   │  1500   │  1000   │   750   │
% └─────────┴─────────┴─────────┴─────────┴─────────┘

pTabel = [1, 2, 3, 4];       % Numărul de perechi de poli
n1Tabel = [3000, 1500, 1000, 750]; % Turații sincrone [rot/min]
% Determinarea lui 'p' pe baza turației 'n'
for i = 1:3
    if n1Tabel(i) > n && n1Tabel(i+1) < n
        % p = 60 * f1 / n1Tabel(i);
        p = pTabel(i);
        break;
    end
end
% Randamentul și factorul de putere nominal
etaN = 0.918;  % Randamentul nominal
cosFiN = 0.922; % Factorul de putere cos(fi) nominal
% Calculați U1, Sn și I1n
U1 = Un / sqrt(3) % Tensiunea de fază
Sn = Pn / (etaN * cosFiN) % Puterea aparentă nominală [VA]
I1n = Sn / (3 * U1) % Curentul de fază nominal [A]
IN = I1n;
% Tensiunea electromotoare pe fază și puterea aparentă internă
kE = 0.98 - p * 5e-3 % coeficient de aproximare
E1 = kE * U1 % t.e.m.
Sin = 3 * E1 * I1n % Puterea aparentă internă [VA]
% Alegerea coeficienților care intervin în expresia puterii aparente interne
kw = 0.92;  % Factor de înfășurare
ksd = 1.28; % Coeficient de saturație
alfai = 0.708; % Coeficient alfa
kB = 1.0925; % Coeficient kB
% ============================================================
%               Calculul dimensiunilor principale
% ============================================================
% Diametrul interior al statorului
C = 248; % Densitatea de curent [J/dm^3]



%                   Date tabelare (Tabelul 2.2)
% +------------------------------------------------------------+
% |     p    |     1     |     2     |      3     |      4     |
% +----------+-----------+-----------+------------+------------+
% |  lambda  | 0.35-1.25 |  0.5-1.75 |  0.65-1.9  |  0.75-2.2  |
% +------------------------------------------------------------+
lambda = 0.37; % Coeficient lambda [-]
D = fix(23.32 * (p^2 * Sin / ( 1000 * lambda * C))^(1/3)) + 1; % Diametrul interior al statorului [cm]
D = 10 * D
% Diametrul exterior al statorului
%                   Date tabelare (Tabelul 2.3)
% +------------------------------------------------------------+
% |     p    |     1     |     2     |      3     |      4     |
% +----------+-----------+-----------+------------+------------+
% |    kD    | 1.65-1.69 | 1.46-1.49 |  1.37-1.4  |  1.27-1.3  |
% +------------------------------------------------------------+

kD = 1.66;  % Coeficientul kD
De = kD * D; % Diametrul exterior al statorului [mm]
De = 470
tau = pi * D / (2 * p) % Lungimea pasului polar [mm]
A = 472; % Patura de curent [A/cm]
Bdelta = 0.675; % Inducția magnetică la intrefier [T]
lg = (2 * p * Sin * 1e7) / (1000 * kB * kw * alfai * D^2 * A * Bdelta) % Lungimea geometrica [mm]
lg = 171;
delta = 0.03 * (4 + 0.7 * sqrt(D * lg * 10^-2)) % Lungimea intrefierului [mm]
delta = 0.6; % recomandat 0.60 mm

%===========================[ETAPA 2]=================================
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
kw1 = 0.922;
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
IN = 216.9660;  % [A]
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
dc = 1.55;

Scond = pi * dc^2 / 4
Scu1 = 10 * Scond
iz = 0.04;
dci = dc + 2 * iz
kFe = 0.95;
Bd1 = 1.7;
bd1 = 10 * t1 * Bdelta / (kFe * Bd1) %  [mm]
ku = 0.75;
Scr = ntot * dci^2 / ku % [mm^2]
bistm1 = 3.25; % [mm]
histm1 = 1.8; % [mm]
hpana = 3; % [mm]
giz = 0.4; % [mm]

% [mm]
bcr1v = (D + 2 * histm1 + 2 * hpana + 4 * giz) * pi / Z1 - bd1
hutilcr1 = (sqrt((bcr1v - 2 * giz)^2 + 4 * Scr * tan(pi / Z1)) - bcr1v + 2 * giz) / (2 * tan(pi / Z1))
hd1 = hutilcr1 + histm1 + hpana + 4 * giz
bcr1b = (D + 2 * hd1) * pi / Z1 - bd1
bd1v = (D + 2 * histm1 + 2 * hpana) * pi / Z1 - bcr1v
bd1b = (D + 2 * hd1)* pi / Z1 - bcr1b
hj1 = (De - D) / 2 - hd1
% Bj1 = 1.3 ... 1.6 [T]
Bj1 = Flux / (2 * kFe * lg * hj1 * 10^-6)
% [mm^2]
Scr1util = 0.5*((bcr1v - 2*giz)+(bcr1b - 2*giz))*(hd1-histm1-hpana-2*giz) % [mm^2]

%===========================[ETAPA 3]=================================
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
sb = Ib / J2b;
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
sb = ((bcr2v + bcr2b) / 2) * (hcr2 - histm2);

lFe = lg;
Bj2 = 1.3;
hj2 = Flux / (2 * kFe * lFe * Bj2 * 10^-6)
Dir = Dr - 2 * (hd2 + hj2) % [mm]

%===========================[ETAPA 4]=================================
t = [t1*10, t2]; % [mm]
bistm = [bistm1, bistm2];

%----------------------------------------------------------
% calcul t.m.m. intrefier:

gamma12 = (bistm / delta).*(bistm / delta) ./ (5 + bistm ./ delta)
kC12 = t ./ (t - (gamma12 .* delta))
kC1 = kC12(1);
kC2 = kC12(2);
kC = kC1 * kC2;

% delta in [m]
Umdelta = 2 * Bdelta * kC * delta * 10^-3/ (4 * pi * 10^-7)
% t.m.m. a dintilor statorului, rotorului
hd12 = [hd1, hd2];
Bd12 = [Bd1, Bd2];
Hd12 = [50, 35]; % [A/cm]
Umd12 = 2 * Hd12 .* hd12 ./10;

Umd1 = Umd12(1)
Umd2 = Umd12(2)
ksd_ = (Umdelta + Umd1 + Umd2) / Umdelta
if abs(ksd_ - ksd) / ksd_ > 0.25
    fprintf("======================[ FAIL ]======================");
    fprintf("Eroare calcul Ksd: %d %s", abs(ksd_ - ksd) / ksd_, "%");
    fprintf("=====================================================");
else
    fprintf("======================[ PASS ]======================");
    fprintf("Eroare calcul Ksd: %d%s < 25%s", abs(ksd_ - ksd) / ksd_, "%", "%");
end
%----------------------------------------------------------
% t.m.m. a jugului statoric, rotoric
Bj12 = [Bj1, Bj2];
zetta12 = [0.225, 0.45];
Hj12 = [50, 5];

Lj1 = pi * (De - hj1) / (2 * p)
Lj2 = pi * (Dir + hj2) / (2 * p)
Lj12 = [Lj1, Lj2]./10; % [cm]
Umj12 = zetta12 .* Hj12 .* Lj12; 
Umj1 = Umj12(1)
Umj2 = Umj12(2)
% calcule finale:
Umcirc = Umdelta + Umd1 + Umd2 + Umj1 + Umj2
ks = Umcirc / Umdelta;
ks = 2.672;
Imiu = p * Umcirc / (0.9 * m * w1 * kw1)

%===========================[ETAPA 5]=================================

Z = [Z1, Z2];
ytau = Z ./ (2*p) ;
t1 = t1*10; % [mm]
y1 = ytau(1)*5/6 % y1 = Z1*5/6

hcr1 = hd1;  % [mm]
hcr2 = hd2;  % [mm]

tmed = pi * (D + hcr1) / Z1 % [mm]
Rm = y1 * tmed / 2 % [mm]
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
Lb = lg; % [mm]
hisc = hd2 + 7;  % hisc = hd2 + (5 ÷ 10)   [mm]
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

%===========================[ETAPA 6]=================================
pj = 2.4 * (f1 / 50)^2 .* Bj12 .* Bj12; % [W/kg]
Dej = [De, Dr-2*hd2]./10; % diametrele exterioare jug stator, rotor [cm]
Dij = [D+2*hd1, Dr-2*(hd2+hj2)]./10; % diametrele interiorare jug stator, rotor [cm]

% masa jugului statoric, rotoric [kg]
mj = 7.8 * pi * 0.25 * lg * 0.1 * 0.95 * ...
    10^-3 .* (Dej.*Dej - Dij.*Dij);

% Pierderile in jugul rotoric (r) si statoric (s)
kj = 1.38; % coeficient de pierderi kj = 1.3 ... 1.5
Pj = kj * pj .* mj % pierderile in jug statoric, rotoric [W]
Bd = [Bd1, Bd2]; % inductia in dintele statoric, rotoric [T]
fsr = [f1, f1]; % frecventele de functionare pentru stator, rotor [Hz]
bd12 = [bd1, bd2]./10 % latimea dintelui statoric, statoric [cm]
hd12 = hd12 ./ 10 % [cm]

pd = 2.4  * Bd .* Bd; % [W/kg]
md = 7.8 * lg * 0.1 * 0.95 * 10^-3 * ...
    hd12 .* bd12 .* Z % masa fierului dintilor statorici, rotorici [kg]
kd = 1.8;
Pd = kd * pd .* md % pierderile in dintii statorici, rotorici [W]
% Pierderile totale in fier: [W]
Pierderi_fe_pr = Pj + Pd
beta0 = [0.3188, 0.2031]; % se alege conform graficului
B0 = beta0 * kC * Bdelta % [T]
% pierderile de suprafata [W/m^2] stator si rotor
p_supr = 0.95 * (n / 10^4)^1.5 * (10 .* B0).^2 .* ...
    Z .^1.5 .* t .^2 ./100;
p_supr = [p_supr(2), p_supr(1)];

% Pierderile de suprafata [W]
P_supr = 2*p*tau*lg*kFe*10^-5 .* ...
    (t - bistm) .* p_supr ./ t
P_sFe = 0.01 * Pn % [W]
% pierderile in pusluri
gamma_12 = (bistm./delta)./(5 + (bistm./delta))
gamma_12 = [gamma_12(2), gamma_12(1)]
% Amplitudinea pulsatiei inductiei magnetice in dinti [T] in stator, rotor
B_puls = 0.5 .* gamma_12 .*  Bd ./ t
% Pierderile la pulsuri [W]
P_puls = 0.1 * (1/1000)^2 * n .* ...
    md .* B_puls.^2 .* [Z2, Z1] .^ 2
% pierderile totale in fier:
Pierderi_Fe = P_sFe + sum(Pierderi_fe_pr) + sum(P_puls + P_supr) % [W]
% Pierderi electrice in infasuratoarea statorului:
m12 = [m1, m2];
R12 = [R1, R2]; % [Ohm]
I12 = [IN , I2]; % curentii calculati stator, rotor [A]

% Pierdeile electrice, [W]
Pierderi_El = sum(m12 .* R12 .* I12 .^2)
% Pierderi mecanice [W]
Pierderi_mec = 0.0264 * p * tau^3 * 0.001
% Pierderile totale
Pierderi = Pierderi_El + Pierderi_Fe + Pierderi_mec
%==================================================================================
% RANDAMENTUL NOMINAL
%==================================================================================
randamentul_nominal = Pn / (Pn + Pierderi)
randamentul_estimat = etaN;
if abs(randamentul_estimat - randamentul_nominal)/randamentul_estimat > 0.05
    fprintf("======================[ FAIL ]======================");
    fprintf("Eroare calcul Randament: %d %s", abs(randamentul_estimat - randamentul_nominal)/randamentul_estimat, "%");
    fprintf("=====================================================");
else
    fprintf("======================[ PASS ]======================");
    fprintf("Eroare calcul Randament: %d%s < 5%s", 100*abs(randamentul_estimat - randamentul_nominal)/randamentul_estimat, "%", "%");
end

%===========================[ETAPA 7]=================================
% Alunecarea:
sN = (R2_/(kE*U1)) * ((m2*w2*kw2*I2N)/(m1*w1*kw))

Pel0 = m1 * R1 * Imiu^2 % [A] I0 ~ Imiu
I0a = (Pierderi_Fe - P_sFe + Pel0 + Pierderi_mec) / (m1 * U1)
I0 = sqrt(I0a^2 + Imiu^2) % [A]
cos_fi0_ = I0a / I0
c1 = 1 + X_sigma1 / Xm
I2a_ = U1 * (R1 + c1 * R2_/sN) / ((R1 + c1 * R2_/sN)^2 + (X_sigma1 + c1 * X_sigma2)^2) % [A]
I2r_ = U1 * (X_sigma1 + c1 * X_sigma2) / ((R1 + c1 * R2_/sN)^2 + (X_sigma1 + c1 * X_sigma2)^2) % [A]
I1N = sqrt((I0a + I2a_)^2 + (Imiu + I2r_)^2)
%==========================================================
% Factorul de putere nominal
cos_fiN_ = (I0a + I2a_) / I1N
% Momentul nominal [N*m]
Mn = (m1 * p * U1^2 * R2_ / sN) / (2*pi*f1*((R1 + c1 * R2_/sN)^2 + (X_sigma1 + c1 * X_sigma2)^2));
Mn_ = 30 * Pn / (pi * (1 - sN) * n)
if abs(Mn - Mn_)/Mn > 0.05
    fprintf("======================[ FAIL ]======================");
    fprintf("Eroare calcul Moment Mn: %d %s", abs(Mn - Mn_) * 100/Mn_, "%");
    fprintf("=====================================================");
else 
    fprintf("======================[ PASS ]======================");
    fprintf("Eroare calcul Moment: %d%s < 5%s", abs(Mn - Mn_) * 100/Mn_, "%", "%");
end
