% EXAMEN FINAL PUNTO 2.4 - 2182467 - Brayan Steven Quitián Espinosa 
% 16/03/2022 - Diseño de reactores D1.
    clc, clear

% DATOS:
K0F = 4.239e6; K0R = 3.631e16; EF = 69.71e6/1000; ER = 139.4e6/1000;
dH = -69.71e6/1000; q0A = 4.377e-3; q0B = 4.377e-3; C0A = 8.01; C0B = 8.01;
R = 8.314; F0A = C0A*q0A; q0 = q0A+q0B; X0 = 0; i = 1;
VR1 = 50; VR2 = 100; VR3 = 200; T(1) = 300;

% METODO ITERATIVO PARA VR = 100 ------------------------------------------
i=1;
for T = 300:316
    KF = K0F*exp(-EF/(R*T));
    KR = K0R*exp(-ER/(R*T));
        a = VR2*(KF-KR);
        b = -(2*KF*VR2+(q0)/C0A);
        c = KF*VR2;
        p = [a b c];
        X2 = roots(p);
    if X2(1) > 0
        if X2(1) < 1
            x2(i) = X2(1);
        else
        end
    end
    if X2(2) > 0
        if X2(2) < 1
            x2(i) = X2(2);
        else
        end
    end
i=i+1;
end
% -------------------------------------------------------------------------
% GRAFICAS
Tem = [300:316];
    subplot(1,1,1),plot(Tem,x2), title('CONVERSION A VS TEMPERATURA')
    grid, xlabel('Temperatura [k]'), ylabel('Conversion')
    legend({'VR = 100'},'Location', 'northeast')
