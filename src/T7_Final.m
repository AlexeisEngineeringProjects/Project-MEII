run("T6_Putere.mlx");

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
%==========================================================

% Momentul nominal [N*m]
Mn = (m1 * p * U1^2 * R2_ / sN) / (2*pi*f1*((R1 + c1 * R2_/sN)^2 + (X_sigma1 + c1 * X_sigma2)^2));
Mn_ = 30 * Pn / (pi * (1 - sN) * n)
if abs(Mn - Mn_)/Mn > 0.05
    fprintf("======================[ ERROR ]======================");
    fprintf("Eroare calcul Moment Mn: %d %s", abs(Mn - Mn_) * 100/Mn_, "%");
    fprintf("=====================================================");
end
