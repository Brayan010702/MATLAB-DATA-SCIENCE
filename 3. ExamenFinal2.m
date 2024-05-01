% EXAMEN FINAL PUNTO 2 - 2182467 - Brayan Steven Quitián Espinosa 
% 16/03/2022 - Diseño de reactores D1.
    clc, clear

% DATOS:
K0F = 4.239e6; K0R = 3.631e16; EF = 69.71e6/1000; ER = 139.4e6/1000;
dH = -69.71e6/1000; q0A = 4.377e-3; q0B = 4.377e-3; C0A = 8.01; C0B = 8.01;
R = 8.314; F0A = C0A*q0A; q0 = q0A+q0B; X0 = 0; i = 1;
V = 100; T(1) = 300; PM = 100; Cp = 3137; Te = 294; U = 851; dt = 0.1;

% METODO ITERATIVO PARA VR = 50 -------------------------------------------
XA1 = 0.4;
    for i = 1:15
        KF = K0F*exp(-EF/(R*T(i)));
        KR = K0R*exp(-ER/(R*T(i)));
        rA(i) = (KF*(C0A*(1-XA1))^2)-(KR*((C0A*(XA1))^2));
        V(i) = F0A*XA1/rA(i); 
        D(i) = (2*V(i)/pi)^(1/3);
        A(i) = 2*pi*D(i)^2;
        Q(i) = F0A*(PM*Cp*(T(i)-Te)+dH*XA1);
        Tj(i) = -Q(i)/(U*A(i)) + Te;
        Mj(i) = Q(i)/(Cp*(Te-T(i)));
        RSI(i) = (T(i)-Tj(i))/(T(i)-Te);
            T(i+1) = T(i) + dt;
    end
T(:,15) = [];
% -------------------------------------------------------------------------
% GRAFICAS

       subplot(3,3,1),plot(T,V), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,2),plot(T,D), title('TEMPERATURA VS DIAMETRO')
    grid, xlabel('Temperatura'), ylabel('Diametro')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,3),plot(T,A,Ti1,Ai1,Ti2,Ai2), title('TEMPERATURA VS AREA')
    grid, xlabel('Temperatura'), ylabel('Area')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,4),plot(T,Mj,Ti1,Mji1,Ti2,Mji2), title('TEMPERATURA VS FLUJO FLUIDO DE ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Flujo de fluido de enfriamiento')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,5),plot(T,Q,Ti1,Qi1,Ti2,Qi2), title('TEMPERATURA VS CALOR')
    grid, xlabel('Temperatura'), ylabel('Calor')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,6),plot(T,rA,Ti1,rAi1,Ti2,rAi2), title('TEMPERATURA VS VELOCIDAD DE REACCION')
    grid, xlabel('Temperatura'), ylabel('Velocidad de rxn')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northwest')

    subplot(3,3,7),plot(T,RSI,Ti1,RSIi1,Ti2,RSIi2), title('TEMPERATURA VS RSI')
    grid, xlabel('Temperatura'), ylabel('RSI')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,8),plot(T,Tj,Ti1,Tji1,Ti2,Tji2), title('TEMPERATURA VS TEMPERATURA ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Temperatura J')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northwest')
