% Código para el cálculo del numero de etapas en un sistema de multiples etapas.
% 2182467 - Brayan Steven Quitián Espinosa. 22/02/2022 - Operaciones unitarias.
    clc; clear;

% INGRESO DE DATOS INICIALES.
    xNR = [0 0.2 0.5 0.75];
    yNR = [0.8333 0.667 0.4167 0.2083];
    Rendi = 80;
    R0 = 400;  XR0 = 19/20;
    EN1 = 960;  YEN1 = 0;
    Xmin = 19/55;  Nmin = 6/11;
    NR0 = 3/2;
    NEN1 = 0;

% SISTEMA ITERATIVO.
% Condición para determinar si es posible solucionar el problema.
    Emin = R0*((XR0 - Xmin)/(Xmin - YEN1));
    if EN1 > Emin
       alpha = EN1/Emin;
       R = R0; XR = XR0; NR = NR0;  m = 0; i = 1; Rend = 0; 
       CoNR = Regresion(xNR,yNR);
          
       % SOLUCION DEL PRIMER BLOQUE
          while Rendi >= Rend
              EN(i) = EN1;
              YEN(i) = YEN1;
              NEN(i) = NEN1;
              XM(i) = ((R(i)*XR(i))+(EN(i)*YEN(i)))/(R(i)+EN(i));
              XR(i+1) = XM(i);  YE(i) = XM(i);
              % Sumatoria para realizar el polinomio y obtener la función
              % de retención NR
                   n = 0;
                   for e = 1:6
                       N(e) = CoNR(e)*XR(i+1)^(e-1) + n;
                       n = N(e);
                   end
              NR(i+1) = N(e);
              NE(i) = Arrastre (YE(i));

                   % SOLUCION SISTEMA DE ECUACIONES LINEALES.
                   A = [XR(i+1) YE(i); NR(i+1) NE(i)];
                   B = [R(i)*XR(i)+EN(i)*YEN(i); R(i)*NR(i)+EN(i)*NEN(i)];
                   C = inv(A)*B;
                   R(i+1) = C(1,1);
                   E(i) = C(2,1);
           
                   % SOLUCION DEL SEGUNDO BLOQUE, sumatoria para obtener el
                   % rendimiento final
                    S(i) = E(i)*YE(i) + m;
                    m = S(i);
                    Rend(i+1) = (S(i))/((R0*XR0)+(i*EN1*YEN1))*100; 
          i = i+1;        
          end
    else 
        msgbox('El problema no tiene solución, EN+1 debe ser mayor a EN+1min.', 'ADVERTENCIA')
    end

% RESULTADOS
    RendFinal = Rend(i);
    res = ['Para obtener un rendimiento del ', num2str(Rendi), '% se necesitan ', num2str(i-1), ' etapas.'];
    disp(res)

    NumeroEtapas = [0:1:i-1];
    plot(NumeroEtapas, Rend), title('RENDIMIENTO VS ETAPA')
    grid
    xlabel('Numero de etapas')
    ylabel('Rendimiento [%]')
    legend({'Rendimiento'},'Location','southeast')

