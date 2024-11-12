% ============================================================
%              Calculul Puterii Aparente interne
% ============================================================
run("HeaderScript.m"); % add the header script

%               Date tabelare (Tabelul 2.1)
% +------------------------------------------------------+
% |     p    |     1    |     2    |     3    |     4    |
% +----------+----------+----------+----------+----------+
% |    n1    |   3000   |   1500   |   1000   |   750    |
% +------------------------------------------------------+
pTabel = [1, 2, 3, 4];       % Numărul de perechi de poli
n1Tabel = [3000, 1500, 1000, 750]; % Turații sincrone [rot/min]
p = NaN; % Determinarea lui 'p' pe baza turației 'n'
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
Sn = Pn / (etaN * cosFiN); % Puterea aparentă nominală [VA]
I1n = Sn / (3 * U1) % Curentul de fază nominal [A]
IN = I1n;
% Tensiunea electromotoare pe fază și puterea aparentă internă
kE = 0.98 - p * 5e-3; % coeficient de aproximare
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

delta = 0.03 * (4 + 0.7 * sqrt(D * lg * 10^-2)) % Lungimea intrefierului [mm]
% recomandat 0.70 mm
