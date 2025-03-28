%----------------------------------------------------------
t = [t1*10, t2]; % [mm]
bistm = [bistm1, bistm2];
%----------------------------------------------------------
% calcul t.m.m. intrefier:

gamma12 = (bistm / delta).*(bistm / delta) ./ (5 + bistm ./ delta);
kC12 = t ./ (t - (gamma12 .* delta));

kC1 = kC12(1);
kC2 = kC12(2);
kC = kC1 * kC2;

% delta in [m]
Umdelta = 2 * Bdelta * kC * delta * 10^-3/ (4 * pi * 10^-7);

%----------------------------------------------------------
% t.m.m. a dintilor statorului, rotorului
hd12 = [hd1, hd2];
Bd12 = [Bd1, Bd2];

Hd12 = [50, 35]; % [A/cm]

Umd12 = 2 * Hd12 .* hd12 ./10;

Umd1 = Umd12(1);
Umd2 = Umd12(2);

ksd_ = (Umdelta + Umd1 + Umd2) / Umdelta;

if abs(ksd_ - ksd) / ksd_ > 0.25
    rez = "FAIL";
    sign = ">";
else
    rez = "PASS";
    sign = "<";
end

fprintf("\n======================[ %s ]=======================\n", rez);
fprintf("\t\t%s Ksd: %.2f %s %s 25 %s", rez, abs(ksd_ - ksd) / ksd_, "%", sign, "%");
fprintf("\n=====================================================\n\n");
%----------------------------------------------------------
% t.m.m. a jugului statoric, rotoric
Bj12 = [Bj1, Bj2];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zetta12 = [0.225, 0.45]; % interpolation function needed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Hj12 = [50, 5];

Lj1 = pi * (De - hj1) / (2 * p);
Lj2 = pi * (Dir + hj2) / (2 * p);
Lj12 = [Lj1, Lj2]./10; % [cm]


Umj12 = zetta12 .* Hj12 .* Lj12; 

Umj1 = Umj12(1);
Umj2 = Umj12(2);

%----------------------------------------------------------
% calcule finale:

Umcirc = Umdelta + Umd1 + Umd2 + Umj1 + Umj2;

ks = Umcirc / Umdelta;
Imiu = p * Umcirc / (0.9 * m * w1 * kw1);

fprintf("[ PASS ] T4 Script finished succesfully!\n");
