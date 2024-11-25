run("T3_calculIndus");
(* 
Bdelta = 0;
kC = 0;
delta = 0;
t = [0, 0];
bistm = [0, 0]; *)

%----------------------------------------------------------
% calcul t.m.m. intrefier:

Umdelta = 2 * Bdelta * kC * delta;

kC12 = [0, 0];
gamma12 = [0, 0];

for w = 1:length(t)
    gamma12(w) = (bistm(w) / delta)^2 / (5 + bistm(w) / delta);
    kC12(w) = t(w) / (t(w) - gamma12(w) * delta); 
end

kC1 = kC12(1);
kC2 = kC12(2);
kC = kC1 * kC2;

%----------------------------------------------------------
% t.m.m. a dintilor statorului, rotorului
hd12 = [0, 0];
Bd12 = [0, 0];

Hd12 = [0, 0];
Umd12 = [0, 0];
for w = 1:2
    Hd12(w) = Bd12(w) / (4 * 3.141592653 * 10^-4);
    Umd12(w) = 2 * Hd12(w) * hd12(w);
end

Umd1 = Umd12(1);
Umd2 = Umd12(2);

ksd = 0;
_ksd_ = (Umdelta + Umd1 + Umd2) / Umdelta;

if (_ksd_ - ksd) / ksd > 0.25
    disp('[ ERROR ] ksd error bigger then 25%');
else
    % Do nothing
end

%----------------------------------------------------------
% t.m.m. a jugului statoric, rotoric
Bj12 = [0, 0];
Hj12 = [0, 0];

Lj1 = pi * (De - hj1) / (2 * p);
Lj2 = pi * (Dir - hj2) / (2 * p);

Umj12 = [0, 0];

Lj12 = [Lj1, Lj2];
for w = 1:2
    Hj12(w) = Bj12(w) / (4 * 3.141592653 * 10^-4);
    Umj12(w) = zetta12(w) * Hj12(w) * Lj12(w);
end

Umj1 = Umj12(1);
Umj2 = Umj12(2);

%----------------------------------------------------------
% calcule finale:

Umcirc = Umdelta + Umd1 + Umd2 + Umj1 + Umj2;
Imiu = p * Umcirc / (0.9 * m * w1 * kw1);
