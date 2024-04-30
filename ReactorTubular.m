% Reactor tubular empacado - 2182467 - Brayan Steven Quitián Espinosa 
% 05/03/2022 - DISEÑO DE REACTORES D1.
    clc, clear
% Reacción de primer orden, en fase gaseosa, exotérmica, en reactor tubular
% empacado.
% DATOS
    q = 20; P0 = 10; T0 = 450; R = 0.082;       % q[L/s] P[atm] T[K] R[L*atm/mol*k]
    CA0 = P0/(R*T0);                            % Gases ideales 
    FA0 = q*CA0;
    dH = -20e3; CpA = 40; CpB = 25; CpC = 15; alpha = 0.019;
    Te = 323.15; Uarhob = 0.8;              % [K] [J/cat*kg*s*k]

% ITERACIONES -------------------------------------------------------------
caso = input('Escriba el caso de operación: ');
if caso == 1
    i = 1; dw = 0.1; T(i) = T0; XA(i) = 0; P(i) = P0; w(i) = 0;
    while XA(i) < 0.99
        k = 0.1333*exp((31.4/8.314e-3)*((1/450)-(1/T(i))));
        CA = (CA0*(1-XA(i)))/((1+XA(i))*(T(i)/T0)*(P0/P(i)));
        rA = k*CA;
        dXA = rA/FA0;
        dT = (-rA*dH)/(FA0*(CpA+(-CpA+CpB+CpC)*XA(i))); 
        dP = 0;

        XA(i+1) = XA(i) + dXA*dw;
        T(i+1) = T(i) + dT*dw;
        P(i+1) = P(i) + dP*dw;
        w(i+1) = w(i) + dw;
   
        i = i+1;
    end
elseif caso == 2
    i = 1; dw = 0.1; T(i) = T0; XA(i) = 0; P(i) = P0; w(i) = 0;
    while P(i) > 2
        k = 0.1333*exp((31.4/8.314e-3)*((1/450)-(1/T(i))));
        CA = (CA0*(1-XA(i)))/((1+XA(i))*(T(i)/T0)*(P0/P(i)));
        rA = k*CA;
        dXA = rA/FA0;
        dT = (-rA*dH)/(FA0*(CpA+(-CpA+CpB+CpC)*XA(i))); 
        dP = (-alpha/2)*(T(i)/T0)*((P0*P0)/P(i))*(1+XA(i));

        XA(i+1) = XA(i) + dXA*dw;
        T(i+1) = T(i) + dT*dw;
        P(i+1) = P(i) + dP*dw;
        w(i+1) = w(i) + dw;
   
        i = i+1;
    end
elseif caso == 3
    i = 1; dw = 0.1; T(i) = T0; XA(i) = 0; P(i) = P0; w(i) = 0; 
    while P(i) > 2
        k = 0.1333*exp((31.4/8.314e-3)*((1/450)-(1/T(i))));
        CA = (CA0*(1-XA(i)))/((1+XA(i))*(T(i)/T0)*(P0/P(i)));
        rA = k*CA;
        dXA = rA/FA0;
        dT = ((Uarhob*(Te-T(i)))-(rA*dH))/(FA0*(CpA+(-CpA+CpB+CpC)*XA(i))); 
        dP = (-alpha/2)*(T(i)/T0)*((P0*P0)/P(i))*(1+XA(i));

        XA(i+1) = XA(i) + dXA*dw;
        T(i+1) = T(i) + dT*dw;
        P(i+1) = P(i) + dP*dw;
        w(i+1) = w(i) + dw;
        i = i+1;
    end
end
%--------------------------------------------------------------------------
% RESULTADOS 
% GRAFICA
    subplot(1,3,1),plot(w,XA), title('CONVERSIÓN VS PESO CATALIZADOR')
    grid
    xlabel('Peso catalizador [kg]')
    ylabel('Conversión [%]')
    legend({'Conversión'},'Location','southeast')

    subplot(1,3,2),plot(w,T), title('TEMPERATURA VS PESO CATALIZADOR')
    grid
    xlabel('Peso catalizador [kg]')
    ylabel('Temperatura [k]')
    legend({'Temperatura'},'Location','southeast')

    subplot(1,3,3),plot(w,P), title('PRESIÓN VS PESO CATALIZADOR')
    grid
    xlabel('Peso catalizador [kg]')
    ylabel('Presión [atm]')
    legend({'Presión'},'Location','southeast')

% TABLA    
    Conversion_A = reshape(XA,[i,1]);
    Temperatura = reshape(T,[i,1]);
    Presion = reshape(P,[i,1]);
    Peso_catalizador = reshape(w,[i,1]);
    table(Peso_catalizador, Conversion_A, Temperatura, Presion)
% FIN