% Reactor batch punto 1 - 2182467 - Brayan Steven Quitián Espinosa 
% 05/03/2022 - DISEÑO DE REACTORES - D1.
    clc, clear
% A ----> P             r = kCA
% ECUACIÓN PARA LA VARIACIÓN DE LA CONVERSIÓN (XA):
    % dXA/dt = rA*V/NA0
% ECUACIÓN PARA LA VARIACIÓN DE LA TEMPERATURA:
    % dT/dt = (Q-dH*rA*V)/(Ni*Cpi)

% VALORES INICIALES DEL PROBLEMA
    K0 = 4e6;                                   %s^-1
    E = 65.681e6;                               %J/kmol
    rhoCp = 4.2e6;                              %J/K*m^3
    dH = -1670e-3;                              %J/kg
    Uc = 1360;                                  %Wm^-2K^-1
    T0 = 293;                                   %k
    R = 8314;                                   %Jkmol^-1K^-1
    Tac = 393;                                  %k
    Ue = 1180;                                  %Wm^-2K^-1
    Tae = 288;                                  %k
    V = 5;                                      %m^3
    A = 3.3;                                    %m^2
    PMA = 100;                                  %kg/kmol
    CA0 = 1;                                    %kmol/m^3
    Tmax = 368;                                 %k
    tllenado = 600;                             %s
    tvaciado = 900;                             %s
    XA0 = 0;       
%--------------------------------------------------------------------------
caso = input('Escriba el caso de operación: ');
if caso == 1
% METODO ITERATIVO ETAPA 1 ------------------------------------------------
    i = 1; dt = 0.2; XAe1(i) = XA0; Te1(i) = T0; te1(i) = 0; dXAe1(i) = 0; Qe1(i) = 0;
    while Te1(i) < 328
        dXAe1(i+1) = K0*exp(-E/(R*Te1(i)))*(1-XAe1(i));
        Qe1(i+1) = Uc*A*(Tac-Te1(i));
        dT = (Uc*A*(Tac-Te1(i))-dH*CA0*K0*exp(-E/(R*Te1(i)))*(1-XAe1(i)))/(V*rhoCp);
        XAe1(i+1) = XAe1(i) + dXAe1(i)*dt;
        Te1(i+1) = Te1(i) + dT*dt;
        te1(i+1) = te1(i) + dt;
        i = i+1;
    end
% METODO ITERATIVO ETAPA 2 ------------------------------------------------
    o = 1; dt = 0.2; XAe2(o) = XAe1(i); Te2(o) = Te1(i); te2(o) = te1(i); dXAe2(o) = dXAe1(i); Qe2(o) = Qe1(i);
    while XAe2(o) < 0.9
        dXAe2(o+1) = K0*exp(-E/(R*Te2(o)))*(1-XAe2(o));
        Qe2(o+1) = 0;
        dT = (-dH*CA0*K0*exp(-E/(R*Te2(o)))*(1-XAe2(o)))/(V*rhoCp);
        XAe2(o+1) = XAe2(o) + dXAe2(o)*dt;
        Te2(o+1) = Te2(o) + dT*dt;
        te2(o+1) = te2(o) + dt;
        o = o+1;
    end
% METODO ITERATIVO ETAPA 3 ------------------------------------------------
    u = 1; dt = 0.2; XAe3(u) = XAe2(o); Te3(u) = Te2(o); te3(u) = te2(o); dXAe3(u) = dXAe2(o); Qe3(u) = Qe2(o);
    while Te3(u) > 318
        dXAe3(u+1) = K0*exp(-E/(R*Te3(u)))*(1-XAe3(u));
        Qe3(u+1) = Ue*A*(Tae-Te3(u));
        dT = (Ue*A*(Tae-Te3(u))-dH*CA0*K0*exp(-E/(R*Te3(u)))*(1-XAe3(u)))/(V*rhoCp);
        XAe3(u+1) = XAe3(u) + dXAe3(u)*dt;
        Te3(u+1) = Te3(u) + dT*dt;
        te3(u+1) = te3(u) + dt;
        u = u+1;
    end
%--------------------------------------------------------------------------
elseif caso == 2
    % METODO ITERATIVO ETAPA 1 ------------------------------------------------
    i = 1; dt = 0.2; XAe1(i) = XA0; Te1(i) = T0; te1(i) = 0; dXAe1(i) = 0; Qe1(i) = 0;
    while Te1(i) < 350
        dXAe1(i+1) = K0*exp(-E/(R*Te1(i)))*(1-XAe1(i));
        Qe1(i+1) = Uc*A*(Tac-Te1(i));
        dT = (Uc*A*(Tac-Te1(i))-dH*CA0*K0*exp(-E/(R*Te1(i)))*(1-XAe1(i)))/(V*rhoCp);
        XAe1(i+1) = XAe1(i) + dXAe1(i)*dt;
        Te1(i+1) = Te1(i) + dT*dt;
        te1(i+1) = te1(i) + dt;
        i = i+1;
    end
% METODO ITERATIVO ETAPA 2 ------------------------------------------------
    o = 1; dt = 0.2; XAe2(o) = XAe1(i); Te2(o) = Te1(i); te2(o) = te1(i); dXAe2(o) = dXAe1(i); Qe2(o) = Qe1(i);
    while XAe2(o) < 0.9
        dXAe2(o+1) = K0*exp(-E/(R*Te2(o)))*(1-XAe2(o));
        Qe2(o+1) = Uc*A*(Tac-Te1(i));
        dT = 0;
        XAe2(o+1) = XAe2(o) + dXAe2(o)*dt;
        Te2(o+1) = Te2(o) + dT*dt;
        te2(o+1) = te2(o) + dt;
        o = o+1;
    end
% METODO ITERATIVO ETAPA 3 ------------------------------------------------
    u = 1; dt = 0.2; XAe3(u) = XAe2(o); Te3(u) = Te2(o); te3(u) = te2(o); dXAe3(u) = dXAe2(o); Qe3(u) = Qe2(o);
    while Te3(u) > 318
        dXAe3(u+1) = K0*exp(-E/(R*Te3(u)))*(1-XAe3(u));
        Qe3(u+1) = Ue*A*(Tae-Te3(u));
        dT = (Ue*A*(Tae-Te3(u))-dH*CA0*K0*exp(-E/(R*Te3(u)))*(1-XAe3(u)))/(V*rhoCp);
        XAe3(u+1) = XAe3(u) + dXAe3(u)*dt;
        Te3(u+1) = Te3(u) + dT*dt;
        te3(u+1) = te3(u) + dt;
        u = u+1;
    end
end
%--------------------------------------------------------------------------
% GRAFICA
    subplot(2,3,1),plot(te1,XAe1,te2,XAe2,te3,XAe3), title('CONVERSIÓN VS TIEMPO')
    grid, xlabel('Tiempo [s]'), ylabel('Conversión')
    legend({'Conversión A etapa 1', 'Conversión A etapa 2', 'Conversión A etapa 3'},'Location','southeast')

    subplot(2,3,2),plot(te1,Te1,te2,Te2,te3,Te3), title('TEMPERATURA VS TIEMPO')
    grid, xlabel('Tiempo [s]'), ylabel('Temperatura [k]')
    legend({'Temperatura etapa 1', 'Temperatura etapa 2', 'Temperatura etapa 3'},'Location','southeast')

    subplot(2,3,3), plot(XAe1,Te1,XAe2,Te2,XAe3,Te3), title('CONVERSIÓN VS TEMPERATURA')
    grid, xlabel('Conversion'), ylabel('Temperatura [k]')
    legend({'Temperatura etapa 1', 'Temperatura etapa 2', 'Temperatura etapa 3'},'Location','southeast')

    subplot(2,3,4),plot(te1,dXAe1,te2,dXAe2,te3,dXAe3), title('VELOCIDAD DE REACCIÓN VS TIEMPO')
    grid, xlabel('Tiempo [s]'), ylabel('Velocidad de reacción')
    legend({'Vrxn etapa 1', 'Vrxn etapa 2', 'Vrxn etapa 3'},'Location','northeast')

    subplot(2,3,5),plot(te1,Qe1,te2,Qe2,te3,Qe3), title('CALOR INTERCAMBIADO VS TIEMPO')
    grid, xlabel('Tiempo [s]'), ylabel('Calor intercambiado')
    legend({'Calor etapa 1', 'Calor etapa 2', 'Calor etapa 3'},'Location','northeast')
% FIN