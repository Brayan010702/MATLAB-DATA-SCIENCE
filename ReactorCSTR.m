% Reactor CSTR - 2182467 - Brayan Steven Quitián Espinosa 
% 08/03/2022 - Diseño de reactores D1.
    clc, clear

caso = input('Escriba el caso de operación: ');
if caso == 1
% DATOS:
    q = 4.377e-3; CA0 = 8.01; K0 = 20.75e6; Ea = 69.71e6; R = 8.314e3; 
    LD = 2; T1(1) = 320; M = 100; Cp = 3137; dH = -69.71e6; Te = 294;
    U = 851; FA0 = q*CA0; dt = 1; rho = 801; rhoj = 1000; Cpj = 4183;
    T2(1) = 320; T3(1) = 320;

% Primer conversion O.5 ---------------------------------------------------
XA1 = 0.5;
    for i = 1:40
        rA1(i) = K0*exp(-Ea/(R*T1(i)))*CA0*(1-XA1);
        V1(i) = FA0*XA1/rA1(i); 
        D1(i) = (2*V1(i)/pi)^(1/3);
        A1(i) = 2*pi*D1(i)^2;
        Q1(i) = FA0*(M*Cp*(T1(i)-Te)+dH*XA1);
        Tj1(i) = -Q1(i)/(U*A1(i)) + Te;
        Mj1(i) = Q1(i)/(Cp*(Te-T1(i)));
        RSI1(i) = (T1(i)-Tj1(i))/(T1(i)-Te);
            T1(i+1) = T1(i) + dt;
    end
T1(:,40) = [];
% Segunda conversion O.8 ---------------------------------------------------
XA2 = 0.8;
    for i = 1:40
        rA2(i) = K0*exp(-Ea/(R*T2(i)))*CA0*(1-XA2);
        V2(i) = FA0*XA2/rA2(i); 
        D2(i) = (2*V2(i)/pi)^(1/3);
        A2(i) = 2*pi*D2(i)^2;
        Q2(i) = FA0*(M*Cp*(T2(i)-Te)+dH*XA2);
        Tj2(i) = -Q2(i)/(U*A2(i)) + Te;
        Mj2(i) = Q2(i)/(Cp*(Te-T2(i)));
        RSI2(i) = (T2(i)-Tj2(i))/(T2(i)-Te);
            T2(i+1) = T2(i) + dt;
    end
T2(:,40) = [];
% Tercer conversion 0.9 ---------------------------------------------------
XA3 = 0.9;
    for i = 1:40
        rA3(i) = K0*exp(-Ea/(R*T3(i)))*CA0*(1-XA3);
        V3(i) = FA0*XA3/rA3(i); 
        D3(i) = (2*V3(i)/pi)^(1/3);
        A3(i) = 2*pi*D3(i)^2;
        Q3(i) = FA0*(M*Cp*(T3(i)-Te)+dH*XA3);
        Tj3(i) = -Q3(i)/(U*A3(i)) + Te;
        Mj3(i) = Q3(i)/(Cp*(Te-T3(i)));
        RSI3(i) = (T3(i)-Tj3(i))/(T3(i)-Te);
            T3(i+1) = T3(i) + dt;
    end
T3(:,40) = [];
%--------------------------------------------------------------------------
% GRAFICAS
    subplot(3,3,1),plot(T1,V1,T2,V2,T3,V3), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northeast')

    subplot(3,3,2),plot(T1,D1,T2,D2,T3,D3), title('TEMPERATURA VS DIAMETRO')
    grid, xlabel('Temperatura'), ylabel('Diametro')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northeast')

    subplot(3,3,3),plot(T1,A1,T2,A2,T3,A3), title('TEMPERATURA VS AREA')
    grid, xlabel('Temperatura'), ylabel('Area')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northeast')

    subplot(3,3,4),plot(T1,Mj1,T2,Mj2,T3,Mj3), title('TEMPERATURA VS FLUJO FLUIDO DE ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Flujo de fluido de enfriamiento')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northeast')

    subplot(3,3,5),plot(T1,Q1,T2,Q2,T3,Q3), title('TEMPERATURA VS CALOR')
    grid, xlabel('Temperatura'), ylabel('Calor')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northeast')

    subplot(3,3,6),plot(T1,rA1,T2,rA2,T3,rA3), title('TEMPERATURA VS VELOCIDAD DE REACCION')
    grid, xlabel('Temperatura'), ylabel('Velocidad de rxn')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northwest')

    subplot(3,3,7),plot(T1,RSI1,T2,RSI2,T3,RSI3), title('TEMPERATURA VS RSI')
    grid, xlabel('Temperatura'), ylabel('RSI')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northeast')

    subplot(3,3,8),plot(T1,Tj1,T2,Tj2,T3,Tj3), title('TEMPERATURA VS TEMPERATURA ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Temperatura J')
    legend({'XA=0.5', 'XA=0.8', 'XA=0.9'},'Location', 'northwest')
% -------------------------------------------------------------------------
elseif caso == 2 
    q = 4.377e-3; CA0 = 8.01; K0 = 20.75e6; Ea = 69.71e6; R = 8.314e3; 
    LD = 2; T(1) = 320; M = 100; Cp = 3137; dH = -69.71e6; Te = 294;
    U = 851; FA0 = q*CA0; dt = 1; rho = 801; rhoj = 1000; Cpj = 4183;
    Ti(1) = 320; FA0i = FA0 + FA0*0.5; XA = 0.8;
    % Con incremento
    for i = 1:40
        rAi(i) = K0*exp(-Ea/(R*Ti(i)))*CA0*(1-XA);
        Vi(i) = FA0i*XA/rAi(i); 
        Di(i) = (2*Vi(i)/pi)^(1/3);
        Ai(i) = 2*pi*Di(i)^2;
        Qi(i) = FA0i*(M*Cp*(Ti(i)-Te)+dH*XA);
        Tji(i) = -Qi(i)/(U*Ai(i)) + Te;
        Mji(i) = Qi(i)/(Cp*(Te-Ti(i)));
        RSIi(i) = (Ti(i)-Tji(i))/(Ti(i)-Te);
            Ti(i+1) = Ti(i) + dt;
    end
    Ti(:,40) = [];
    % Sin incremento
    for i = 1:40
        rA(i) = K0*exp(-Ea/(R*T(i)))*CA0*(1-XA);
        V(i) = FA0*XA/rA(i); 
        D(i) = (2*V(i)/pi)^(1/3);
        A(i) = 2*pi*D(i)^2;
        Q(i) = FA0*(M*Cp*(T(i)-Te)+dH*XA);
        Tj(i) = -Q(i)/(U*A(i)) + Te;
        Mj(i) = Q(i)/(Cp*(Te-T(i)));
        RSI(i) = (T(i)-Tj(i))/(T(i)-Te);
            T(i+1) = T(i) + dt;
    end
    T(:,40) = [];
    subplot(3,3,1),plot(T,V,Ti,Vi), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northeast')

    subplot(3,3,2),plot(T,D,Ti,Di), title('TEMPERATURA VS DIAMETRO')
    grid, xlabel('Temperatura'), ylabel('Diametro')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northeast')

    subplot(3,3,3),plot(T,A,Ti,Ai), title('TEMPERATURA VS AREA')
    grid, xlabel('Temperatura'), ylabel('Area')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northeast')

    subplot(3,3,4),plot(T,Mj,Ti,Mji), title('TEMPERATURA VS FLUJO FLUIDO DE ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Flujo de fluido de enfriamiento')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northeast')

    subplot(3,3,5),plot(T,Q,Ti,Qi), title('TEMPERATURA VS CALOR')
    grid, xlabel('Temperatura'), ylabel('Calor')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northeast')

    subplot(3,3,6),plot(T,rA,Ti,rAi), title('TEMPERATURA VS VELOCIDAD DE REACCION')
    grid, xlabel('Temperatura'), ylabel('Velocidad de rxn')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northwest')

    subplot(3,3,7),plot(T,RSI,Ti,RSIi), title('TEMPERATURA VS RSI')
    grid, xlabel('Temperatura'), ylabel('RSI')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northeast')

    subplot(3,3,8),plot(T,Tj,Ti,Tji), title('TEMPERATURA VS TEMPERATURA ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Temperatura J')
    legend({'Sin incremento', 'Con incremento'},'Location', 'northwest')

elseif caso == 3
    q = 4.377e-3; CA0 = 8.01; K0 = 20.75e6; Ea = 69.71e6; R = 8.314e3; 
    LD = 2; T(1) = 320; M = 100; Cp = 3137; dH = -69.71e6; Te = 294;
    U = 851; FA0 = q*CA0; dt = 1; rho = 801; rhoj = 1000; Cpj = 4183;
    Ti1(1) = 320; Ti2(1) = 320; dHi1 = dH + dH*0.1; dHi2 = dH + dH*0.2;
    XA = 0.8;
    % Con incremento 10%
    for i = 1:40
        rAi1(i) = K0*exp(-Ea/(R*Ti1(i)))*CA0*(1-XA);
        Vi1(i) = FA0*XA/rAi1(i); 
        Di1(i) = (2*Vi1(i)/pi)^(1/3);
        Ai1(i) = 2*pi*Di1(i)^2;
        Qi1(i) = FA0*(M*Cp*(Ti1(i)-Te)+dHi1*XA);
        Tji1(i) = -Qi1(i)/(U*Ai1(i)) + Te;
        Mji1(i) = Qi1(i)/(Cp*(Te-Ti1(i)));
        RSIi1(i) = (Ti1(i)-Tji1(i))/(Ti1(i)-Te);
            Ti1(i+1) = Ti1(i) + dt;
    end
    Ti1(:,40) = [];
    % Con incremento 20%
    for i = 1:40
        rAi2(i) = K0*exp(-Ea/(R*Ti2(i)))*CA0*(1-XA);
        Vi2(i) = FA0*XA/rAi2(i); 
        Di2(i) = (2*Vi2(i)/pi)^(1/3);
        Ai2(i) = 2*pi*Di2(i)^2;
        Qi2(i) = FA0*(M*Cp*(Ti2(i)-Te)+dHi2*XA);
        Tji2(i) = -Qi2(i)/(U*Ai2(i)) + Te;
        Mji2(i) = Qi2(i)/(Cp*(Te-Ti2(i)));
        RSIi2(i) = (Ti2(i)-Tji2(i))/(Ti2(i)-Te);
            Ti2(i+1) = Ti2(i) + dt;
    end
    Ti2(:,40) = [];
    % Sin incremento
    for i = 1:40
        rA(i) = K0*exp(-Ea/(R*T(i)))*CA0*(1-XA);
        V(i) = FA0*XA/rA(i); 
        D(i) = (2*V(i)/pi)^(1/3);
        A(i) = 2*pi*D(i)^2;
        Q(i) = FA0*(M*Cp*(T(i)-Te)+dH*XA);
        Tj(i) = -Q(i)/(U*A(i)) + Te;
        Mj(i) = Q(i)/(Cp*(Te-T(i)));
        RSI(i) = (T(i)-Tj(i))/(T(i)-Te);
            T(i+1) = T(i) + dt;
    end
    T(:,40) = [];
    subplot(3,3,1),plot(T,V,Ti1,Vi1,Ti2,Vi2), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northeast')

    subplot(3,3,2),plot(T,D,Ti1,Di1,Ti2,Di2), title('TEMPERATURA VS DIAMETRO')
    grid, xlabel('Temperatura'), ylabel('Diametro')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northeast')

    subplot(3,3,3),plot(T,A,Ti1,Ai1,Ti2,Ai2), title('TEMPERATURA VS AREA')
    grid, xlabel('Temperatura'), ylabel('Area')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northeast')

    subplot(3,3,4),plot(T,Mj,Ti1,Mji1,Ti2,Mji2), title('TEMPERATURA VS FLUJO FLUIDO DE ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Flujo de fluido de enfriamiento')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northeast')

    subplot(3,3,5),plot(T,Q,Ti1,Qi1,Ti2,Qi2), title('TEMPERATURA VS CALOR')
    grid, xlabel('Temperatura'), ylabel('Calor')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northeast')

    subplot(3,3,6),plot(T,rA,Ti1,rAi1,Ti2,rAi2), title('TEMPERATURA VS VELOCIDAD DE REACCION')
    grid, xlabel('Temperatura'), ylabel('Velocidad de rxn')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northwest')

    subplot(3,3,7),plot(T,RSI,Ti1,RSIi1,Ti2,RSIi2), title('TEMPERATURA VS RSI')
    grid, xlabel('Temperatura'), ylabel('RSI')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northeast')

    subplot(3,3,8),plot(T,Tj,Ti1,Tji1,Ti2,Tji2), title('TEMPERATURA VS TEMPERATURA ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Temperatura J')
    legend({'Sin incremento', 'Con incremento 10%', 'Con incremento 20%'},'Location', 'northwest')

elseif caso == 4
    q = 4.377e-3; CA0 = 8.01; K0 = 20.75e6; Ea = 69.71e6; R = 8.314e3; 
    LD = 2; T(1) = 320; M = 100; Cp = 3137; dH = -69.71e6; Te = 294;
    U = 851; FA0 = q*CA0; dt = 1; rho = 801; rhoj = 1000; Cpj = 4183;
    Ti1(1) = 320; Ti2(1) = 320; Ui1 = U - U*0.9; Ui2 = U - U*0.8;
    XA = 0.8;
    % Con disminucion 90%
    for i = 1:40
        rAi1(i) = K0*exp(-Ea/(R*Ti1(i)))*CA0*(1-XA);
        Vi1(i) = FA0*XA/rAi1(i); 
        Di1(i) = (2*Vi1(i)/pi)^(1/3);
        Ai1(i) = 2*pi*Di1(i)^2;
        Qi1(i) = FA0*(M*Cp*(Ti1(i)-Te)+dH*XA);
        Tji1(i) = -Qi1(i)/(Ui1*Ai1(i)) + Te;
        Mji1(i) = Qi1(i)/(Cp*(Te-Ti1(i)));
        RSIi1(i) = (Ti1(i)-Tji1(i))/(Ti1(i)-Te);
            Ti1(i+1) = Ti1(i) + dt;
    end
    Ti1(:,40) = [];
    % Con disminucion 80%
    for i = 1:40
        rAi2(i) = K0*exp(-Ea/(R*Ti2(i)))*CA0*(1-XA);
        Vi2(i) = FA0*XA/rAi2(i); 
        Di2(i) = (2*Vi2(i)/pi)^(1/3);
        Ai2(i) = 2*pi*Di2(i)^2;
        Qi2(i) = FA0*(M*Cp*(Ti2(i)-Te)+dH*XA);
        Tji2(i) = -Qi2(i)/(Ui2*Ai2(i)) + Te;
        Mji2(i) = Qi2(i)/(Cp*(Te-Ti2(i)));
        RSIi2(i) = (Ti2(i)-Tji2(i))/(Ti2(i)-Te);
            Ti2(i+1) = Ti2(i) + dt;
    end
    Ti2(:,40) = [];
    % Sin incremento
    for i = 1:40
        rA(i) = K0*exp(-Ea/(R*T(i)))*CA0*(1-XA);
        V(i) = FA0*XA/rA(i); 
        D(i) = (2*V(i)/pi)^(1/3);
        A(i) = 2*pi*D(i)^2;
        Q(i) = FA0*(M*Cp*(T(i)-Te)+dH*XA);
        Tj(i) = -Q(i)/(U*A(i)) + Te;
        Mj(i) = Q(i)/(Cp*(Te-T(i)));
        RSI(i) = (T(i)-Tj(i))/(T(i)-Te);
            T(i+1) = T(i) + dt;
    end
    T(:,40) = [];
    subplot(3,3,1),plot(T,V,Ti1,Vi1,Ti2,Vi2), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northeast')

    subplot(3,3,2),plot(T,D,Ti1,Di1,Ti2,Di2), title('TEMPERATURA VS DIAMETRO')
    grid, xlabel('Temperatura'), ylabel('Diametro')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northeast')

    subplot(3,3,3),plot(T,A,Ti1,Ai1,Ti2,Ai2), title('TEMPERATURA VS AREA')
    grid, xlabel('Temperatura'), ylabel('Area')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northeast')

    subplot(3,3,4),plot(T,Mj,Ti1,Mji1,Ti2,Mji2), title('TEMPERATURA VS FLUJO FLUIDO DE ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Flujo de fluido de enfriamiento')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northeast')

    subplot(3,3,5),plot(T,Q,Ti1,Qi1,Ti2,Qi2), title('TEMPERATURA VS CALOR')
    grid, xlabel('Temperatura'), ylabel('Calor')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northeast')

    subplot(3,3,6),plot(T,rA,Ti1,rAi1,Ti2,rAi2), title('TEMPERATURA VS VELOCIDAD DE REACCION')
    grid, xlabel('Temperatura'), ylabel('Velocidad de rxn')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northwest')

    subplot(3,3,7),plot(T,RSI,Ti1,RSIi1,Ti2,RSIi2), title('TEMPERATURA VS RSI')
    grid, xlabel('Temperatura'), ylabel('RSI')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northeast')

    subplot(3,3,8),plot(T,Tj,Ti1,Tji1,Ti2,Tji2), title('TEMPERATURA VS TEMPERATURA ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Temperatura J')
    legend({'Sin incremento', 'Con disminucion 90%', 'Con disminucion 80%'},'Location', 'northwest')

elseif caso == 5
    q = 4.377e-3; CA0 = 8.01; K0 = 20.75e6; Ea = 69.71e6; R = 8.314e3; 
    LD = 2; T(1) = 320; M = 100; Cp = 3137; dH = -69.71e6; Te = 294;
    U = 851; FA0 = q*CA0; dt = 1; rho = 801; rhoj = 1000; Cpj = 4183;
    Ti1(1) = 320; Ti2(1) = 320; LD1 = 1; LD2 = 4; XA = 0.8;
    % Con LD = 1
    for i = 1:40
        rAi1(i) = K0*exp(-Ea/(R*Ti1(i)))*CA0*(1-XA);
        Vi1(i) = FA0*XA/rAi1(i); 
        Di1(i) = (4*Vi1(i)/pi)^(1/3);
        Ai1(i) = 2*pi*Di1(i)^2;
        Qi1(i) = FA0*(M*Cp*(Ti1(i)-Te)+dH*XA);
        Tji1(i) = -Qi1(i)/(U*Ai1(i)) + Te;
        Mji1(i) = Qi1(i)/(Cp*(Te-Ti1(i)));
        RSIi1(i) = (Ti1(i)-Tji1(i))/(Ti1(i)-Te);
            Ti1(i+1) = Ti1(i) + dt;
    end
    Ti1(:,40) = [];
    % Con LD = 4
    for i = 1:40
        rAi2(i) = K0*exp(-Ea/(R*Ti2(i)))*CA0*(1-XA);
        Vi2(i) = FA0*XA/rAi2(i); 
        Di2(i) = (Vi2(i)/pi)^(1/3);
        Ai2(i) = 2*pi*Di2(i)^2;
        Qi2(i) = FA0*(M*Cp*(Ti2(i)-Te)+dH*XA);
        Tji2(i) = -Qi2(i)/(U*Ai2(i)) + Te;
        Mji2(i) = Qi2(i)/(Cp*(Te-Ti2(i)));
        RSIi2(i) = (Ti2(i)-Tji2(i))/(Ti2(i)-Te);
            Ti2(i+1) = Ti2(i) + dt;
    end
    Ti2(:,40) = [];
    % Sin incremento
    for i = 1:40
        rA(i) = K0*exp(-Ea/(R*T(i)))*CA0*(1-XA);
        V(i) = FA0*XA/rA(i); 
        D(i) = (2*V(i)/pi)^(1/3);
        A(i) = 2*pi*D(i)^2;
        Q(i) = FA0*(M*Cp*(T(i)-Te)+dH*XA);
        Tj(i) = -Q(i)/(U*A(i)) + Te;
        Mj(i) = Q(i)/(Cp*(Te-T(i)));
        RSI(i) = (T(i)-Tj(i))/(T(i)-Te);
            T(i+1) = T(i) + dt;
    end
    T(:,40) = [];
    subplot(3,3,1),plot(T,V,Ti1,Vi1,Ti2,Vi2), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northeast')

    subplot(3,3,2),plot(T,D,Ti1,Di1,Ti2,Di2), title('TEMPERATURA VS DIAMETRO')
    grid, xlabel('Temperatura'), ylabel('Diametro')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northeast')

    subplot(3,3,3),plot(T,A,Ti1,Ai1,Ti2,Ai2), title('TEMPERATURA VS AREA')
    grid, xlabel('Temperatura'), ylabel('Area')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northeast')

    subplot(3,3,4),plot(T,Mj,Ti1,Mji1,Ti2,Mji2), title('TEMPERATURA VS FLUJO FLUIDO DE ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Flujo de fluido de enfriamiento')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northeast')

    subplot(3,3,5),plot(T,Q,Ti1,Qi1,Ti2,Qi2), title('TEMPERATURA VS CALOR')
    grid, xlabel('Temperatura'), ylabel('Calor')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northeast')

    subplot(3,3,6),plot(T,rA,Ti1,rAi1,Ti2,rAi2), title('TEMPERATURA VS VELOCIDAD DE REACCION')
    grid, xlabel('Temperatura'), ylabel('Velocidad de rxn')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northwest')

    subplot(3,3,7),plot(T,RSI,Ti1,RSIi1,Ti2,RSIi2), title('TEMPERATURA VS RSI')
    grid, xlabel('Temperatura'), ylabel('RSI')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northeast')

    subplot(3,3,8),plot(T,Tj,Ti1,Tji1,Ti2,Tji2), title('TEMPERATURA VS TEMPERATURA ENFRIAMIENTO')
    grid, xlabel('Temperatura'), ylabel('Temperatura J')
    legend({'L/D=2', 'L/D=1', 'L/D=4'},'Location', 'northwest') 

elseif caso == 6
   q = 4.377e-3; CA0 = 8.01; K0 = 20.75e6; Ea = 69.71e6; R = 8.314e3; 
    LD = 2; T(1) = 320; M = 100; Cp = 3137; dH = -69.71e6; Te = 294;
    U = 851; FA0 = q*CA0; dt = 1; rho = 801; rhoj = 1000; Cpj = 4183;
    Ti1(1) = 320; Ti2(1) = 320; XA = 0.8;
    % Con n = 0.5
    for i = 1:40
        rAi1(i) = K0*exp(-Ea/(R*Ti1(i)))*(CA0*(1-XA))^(0.5);
        Vi1(i) = FA0*XA/rAi1(i); 
        Di1(i) = (4*Vi1(i)/pi)^(1/3);
        Ai1(i) = 2*pi*Di1(i)^2;
        Qi1(i) = FA0*(M*Cp*(Ti1(i)-Te)+dH*XA);
        Tji1(i) = -Qi1(i)/(U*Ai1(i)) + Te;
        Mji1(i) = Qi1(i)/(Cp*(Te-Ti1(i)));
        RSIi1(i) = (Ti1(i)-Tji1(i))/(Ti1(i)-Te);
            Ti1(i+1) = Ti1(i) + dt;
    end
    Ti1(:,40) = [];
    % Con n = 1.5
    for i = 1:40
        rAi2(i) = K0*exp(-Ea/(R*Ti2(i)))*(CA0*(1-XA))^(1.5);
        Vi2(i) = FA0*XA/rAi2(i); 
        Di2(i) = (Vi2(i)/pi)^(1/3);
        Ai2(i) = 2*pi*Di2(i)^2;
        Qi2(i) = FA0*(M*Cp*(Ti2(i)-Te)+dH*XA);
        Tji2(i) = -Qi2(i)/(U*Ai2(i)) + Te;
        Mji2(i) = Qi2(i)/(Cp*(Te-Ti2(i)));
        RSIi2(i) = (Ti2(i)-Tji2(i))/(Ti2(i)-Te);
            Ti2(i+1) = Ti2(i) + dt;
    end
    Ti2(:,40) = [];
    % Sin incremento
    for i = 1:40
        rA(i) = K0*exp(-Ea/(R*T(i)))*CA0*(1-XA);
        V(i) = FA0*XA/rA(i); 
        D(i) = (2*V(i)/pi)^(1/3);
        A(i) = 2*pi*D(i)^2;
        Q(i) = FA0*(M*Cp*(T(i)-Te)+dH*XA);
        Tj(i) = -Q(i)/(U*A(i)) + Te;
        Mj(i) = Q(i)/(Cp*(Te-T(i)));
        RSI(i) = (T(i)-Tj(i))/(T(i)-Te);
            T(i+1) = T(i) + dt;
    end
    T(:,40) = [];
    subplot(3,3,1),plot(T,V,Ti1,Vi1,Ti2,Vi2), title('TEMPERATURA VS VOLUMEN')
    grid, xlabel('Temperatura'), ylabel('Volumen')
    legend({'n=1', 'n=0.5', 'n=1.5'},'Location', 'northeast')

    subplot(3,3,2),plot(T,D,Ti1,Di1,Ti2,Di2), title('TEMPERATURA VS DIAMETRO')
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
end
