run("T5_Infasurari.mlx");

pj = 2.4 * (f1 / 50)^2 .* Bj12 .* Bj12; % [W/kg]
pj = [7.029, 4.056]

Dej = [De, Dr-2*hd2]./10; % diametrele exterioare jug stator, rotor [cm]
Dij = [D+2*hd1, Dr-2*(hd2+hj2)]./10; % diametrele interiorare jug stator, rotor [cm]

% masa jugului statoric, rotoric [kg]
mj = 7.8 * pi * 0.25 * lg * 0.1 * 0.95 * ...
    10^-3 .* (Dej.*Dej - Dij.*Dij);

% Pierderile in jugul rotoric (r) si statoric (s)
kj = 1.38; % coeficient de pierderi kj = 1.3 ... 1.5
Pj = kj * pj .* mj % pierderile in jug statoric, rotoric [W]

Bd = [Bd1, Bd2] % inductia in dintele statoric, rotoric [T]
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
p_supr = [p_supr(2), p_supr(1)]
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
m12 = [m1, m2]
R12 = [R1, R2] % [Ohm]
I12 = [IN , I2] % curentii calculati stator, rotor [A]

% Pierdeile electrce, [W]
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
    fprintf("======================[ ERROR ]======================");
    fprintf("Eroare calcul Randament: %d %s", abs(randamentul_estimat - randamentul_nominal)/randamentul_estimat, "%");
    fprintf("=====================================================");
end
