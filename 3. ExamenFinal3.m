% EXAMEN FINAL PUNTO 2 - 2182467 - Brayan Steven Quitián Espinosa 
% 16/03/2022 - Diseño de reactores D1.
    clc, clear

% DATOS:
K0F = 4.239e6; K0R = 3.631e16; EF = 69.71e6/1000; ER = 139.4e6/1000;
dH = -69.71e6/1000; q0A = 4.377e-3; q0B = 4.377e-3; C0A = 8.01; C0B = 8.01;
R = 8.314; F0A = C0A*q0A; q0 = q0A+q0B; X0 = 0; i = 1;
VR1 = 50; VR2 = 100; VR3 = 200; T(1) = 300;

% METODO ITERATIVO PARA VR = 50 -------------------------------------------
for T = 300:400
    KF = K0F*exp(-EF/(R*T));
    KR = K0R*exp(-ER/(R*T));
        a = VR1*(KF-KR);
        b = -(2*KF*VR1+((q0^2)/F0A));
        c = KF*VR1;
        p = [a b c];
        X1 = roots(p);
    if X1(1) > 0
        if X1(1) < 1
            x1(i) = X1(1);
        else
        end
    end
    if X1(2) > 0
        if X1(2) < 1
            x1(i) = X1(2);
        else
        end
    end
    CA1(i)=F0A/q0*(1-x1(i));
    CC1(i)=F0A/q0*x1(i);
i=i+1;
end
% METODO ITERATIVO PARA VR = 100 ------------------------------------------
i=1;
for T = 300:400
    KF = K0F*exp(-EF/(R*T));
    KR = K0R*exp(-ER/(R*T));
        a = VR2*(KF-KR);
        b = -(2*KF*VR2+((q0^2)/F0A));
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
    CA2(i)=F0A/q0*(1-x2(i));
    CC2(i)=F0A/q0*x2(i);
i=i+1;
end
% METODO ITERATIVO PARA VR = 200 ------------------------------------------
i=1;
for T = 300:400
    KF = K0F*exp(-EF/(R*T));
    KR = K0R*exp(-ER/(R*T));
        a = VR3*(KF-KR);
        b = -(2*KF*VR3+((q0^2)/F0A));
        c = KF*VR3;
        p = [a b c];
        X3 = roots(p);
    if X3(1) > 0
        if X3(1) < 1
            x3(i) = X3(1);
        else
        end
    end
    if X3(2) > 0
        if X3(2) < 1
            x3(i) = X3(2);
        else
        end
    end
    CA3(i)=F0A/q0*(1-x3(i));
    CC3(i)=F0A/q0*x3(i);
i=i+1;
end
% -------------------------------------------------------------------------
% GRAFICAS
Tem = [300:400];
    subplot(1,3,1),plot(Tem,x1,Tem,x2,Tem,x3), title('CONVERSION VS TEMPERATURA')
    grid, xlabel('Temperatura [k]'), ylabel('Conversion')
    legend({'VR = 50','VR = 100','VR = 200'},'Location', 'northeast')

    subplot(1,3,2),plot(Tem,CA1,Tem,CA2,Tem,CA3), title('CONCENTRACION A VS TEMPERATURA')
    grid, xlabel('Temperatura [k]'), ylabel('Concentracion A')
    legend({'VR = 50','VR = 100','VR = 200'},'Location', 'northeast')
        
    subplot(1,3,3),plot(Tem,CC1,Tem,CC2,Tem,CC3), title('CONCENTRACION C VS TEMPERATURA')
    grid, xlabel('Temperatura [k]'), ylabel('Concentracion C')
    legend({'VR = 50','VR = 100','VR = 200'},'Location', 'northeast')
