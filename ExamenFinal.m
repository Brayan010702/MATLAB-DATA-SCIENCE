% EXAMEN FINAL PUNTO 1 - 2182467 - Brayan Steven Quitián Espinosa 
% 16/03/2022 - Diseño de reactores D1.
    clc, clear

% DATOS:
K0 = 0.19038; Ea = 69710; PMA = 15; PMB = 20; PMC = 35; miu = 0.18e-4;
CpA = 30; CpB = 40; CpC = 70; dH = -23237; rhoCat = 2000; Dp = 0.003;
P0 = 50; R = 0.08314; phi = 0.4; D = 1.71; L = 17.1; Fe=1.2+2*0.12; 
y0A = 0.5; X0 = 0; A = (pi/4)*D^2; V = A*L; Wcat = rhoCat*V; Te1 = 461; 
Te2 = 463; Te3 = 465; dw = 0.1; i = 1; 
P1(1) = P0; T1(1) = Te1; X1(1) = X0; W1(1) = 0;
P2(1) = P0; T2(1) = Te2; X2(1) = X0; W2(1) = 0;
P3(1) = P0; T3(1) = Te3; X3(1) = X0; W3(1) = 0;

% METODO ITERATIVO PARA LA PRIMER TEMPERATURA 461 -------------------------
    while W1(i) < Wcat
        qo = Fe*R*Te1/P0;
        q = qo*(P0/P1(i))*(T1(i)/Te1)*(1-y0A*X1(i));
        Vel = q/A;
        yA = (y0A*(1-X1(i)))/(1-y0A*X1(i));
        PMprom = PMC + yA*(PMA+PMB-2*PMC);
        rhog = (P1(i)*PMprom)/(R*T1(i));
        K = K0*exp(-Ea/((R*100)*T1(i)));
        rA = K*(yA*P1(i))^2;
        Re = Dp*Vel*rhog/miu;
        f = ((1-phi)/(phi^3))*(1.75+150*((1-phi)/Re));
        
        dX = rA/(y0A*Fe);
        dP = (-f*(Vel^2)*rhog*L)/(Dp*(Wcat)*(10e5));
        dT = (-dH*rA)/((Fe*y0A)*((CpA+CpB)+(CpC-CpB-CpA)*X1(i)));
        
        X1(i+1) = dX*dw+X1(i);
        P1(i+1) = dP*dw+P1(i);
        T1(i+1) = dT*dw+T1(i);
        W1(i+1) = dw+W1(i);
            
        i=i+1;
    end 
    i = 1;
% METODO ITERATIVO PARA LA PRIMER TEMPERATURA 463 -------------------------
    while W2(i) < Wcat
        qo = Fe*R*Te2/P0;
        q = qo*(P0/P2(i))*(T2(i)/Te2)*(1-y0A*X2(i));
        Vel = q/A;
        yA = (y0A*(1-X2(i)))/(1-y0A*X2(i));
        PMprom = PMC + yA*(PMA+PMB-2*PMC);
        rhog = (P2(i)*PMprom)/(R*T2(i));
        K = K0*exp(-Ea/((R*100)*T2(i)));
        rA = K*(yA*P2(i))^2;
        Re = Dp*Vel*rhog/miu;
        f = ((1-phi)/(phi^3))*(1.75+150*((1-phi)/Re));
        
        dX = rA/(y0A*Fe);
        dP = (-f*(Vel^2)*rhog*L)/(Dp*(Wcat)*(10e5));
        dT = (-dH*rA)/((Fe*y0A)*((CpA+CpB)+(CpC-CpB-CpA)*X2(i)));
        
        X2(i+1) = dX*dw+X2(i);
        P2(i+1) = dP*dw+P2(i);
        T2(i+1) = dT*dw+T2(i);
        W2(i+1) = dw+W2(i);
            
        i=i+1;
    end 
% METODO ITERATIVO PARA LA PRIMER TEMPERATURA 465 -------------------------
    i = 1;    
    while W3(i) < Wcat
        qo = Fe*R*Te3/P0;
        q = qo*(P0/P3(i))*(T3(i)/Te3)*(1-y0A*X3(i));
        Vel = q/A;
        yA = (y0A*(1-X3(i)))/(1-y0A*X3(i));
        PMprom = PMC + yA*(PMA+PMB-2*PMC);
        rhog = (P3(i)*PMprom)/(R*T3(i));
        K = K0*exp(-Ea/((R*100)*T3(i)));
        rA = K*(yA*P3(i))^2;
        Re = Dp*Vel*rhog/miu;
        f = ((1-phi)/(phi^3))*(1.75+150*((1-phi)/Re));
        
        dX = rA/(y0A*Fe);
        dP = (-f*(Vel^2)*rhog*L)/(Dp*(Wcat)*(10e5));
        dT = (-dH*rA)/((Fe*y0A)*((CpA+CpB)+(CpC-CpB-CpA)*X3(i)));
        
        X3(i+1) = dX*dw+X3(i);
        P3(i+1) = dP*dw+P3(i);
        T3(i+1) = dT*dw+T3(i);
        W3(i+1) = dw+W3(i);
            
        i=i+1;
    end 
%--------------------------------------------------------------------------
% GRAFICAS 
    subplot(1,3,1),plot(W1,X1,W2,X2,W3,X3), title('CONVERSION VS PESO DEL CATALIZADOR')
    grid, xlabel('Peso del catalizador [kg]'), ylabel('Conversion')
    legend({'T = 461','T = 463', 'T = 465'},'Location', 'northeast')

    subplot(1,3,2),plot(W1,T1,W2,T2,W3,T3), title('TEMPERATURA VS PESO DEL CATALIZADOR')
    grid, xlabel('Peso del catalizador [kg]'), ylabel('Temperatura [K]')
    legend({'T = 461','T = 463', 'T = 465'},'Location', 'northeast')

    subplot(1,3,3),plot(W1,P1,W2,P2,W3,P3), title('PRESION VS PESO DEL CATALIZADOR')
    grid, xlabel('Peso del catalizador [kg]'), ylabel('Presion [bar]')
    legend({'T = 461','T = 463', 'T = 465'},'Location', 'northeast')
% FIN