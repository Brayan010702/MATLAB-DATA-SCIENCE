% Código para el cálculo del rendimiento en un sistema de multiples etapas.
% 2182467 - Brayan Steven Quitián Espinosa. 
% 22/02/2022 - Operaciones unitarias.
    clc
    clear

% INGRESO DE DATOS INICIALES.
    N = 3;
    R0 = 400;  XR0 = 19/20;
    EN1 = 960;  YEN1 = 0;
    Xmin = 19/55;  Nmin = 6/11;
    NR0 = 3/2;
    NEN1 = 0;

    Emin = R0*((XR0 - Xmin)/(Xmin - YEN1));

    % SISTEMA ITERATIVO.
    if EN1 > Emin
        alpha = EN1/Emin;

    R = R0; XR = XR0; NR = NR0;  m = 0; Rend = 0;
   
       for i=1:N
           % SOLUCION DEL PRIMER BLOQUE
           EN(i) = EN1;
           YEN(i) = YEN1;
           NEN(i) = NEN1;

           XM(i) = ((R(i)*XR(i))+(EN(i)*YEN(i)))/(R(i)+EN(i));
           XR(i+1) = XM(i);  YE(i) = XM(i);
           NR(i+1) = Retencion (XR(i+1));
           NE(i) = Arrastre (YE(i));

                % SOLUCION SISTEMA DE ECUACIONES LINEALES.
                A = [XR(i+1) YE(i); NR(i+1) NE(i)];
                B = [R(i)*XR(i)+EN(i)*YEN(i); R(i)*NR(i)+EN(i)*NEN(i)];
                C = inv(A)*B;

           R(i+1) = C(1,1);
           E(i) = C(2,1);
        
                % SOLUCION DEL SEGUNDO BLOQUE
                 S(i) = E(i)*YE(i) + m;
                 m = S(i);
                 Rend(i+1) = (S(i))/((R0*XR0)+(i*EN1*YEN1))*100; 
       end

    else 
        msgbox('El problema no tiene solución, EN+1 debe ser mayor a EN+1min.', 'ADVERTENCIA')
    end

% RESULTADOS
    RendFinal = Rend(N);
    x = ['El rendimiento en la etapa ', num2str(N), ' es: ', num2str(RendFinal), '%'];
    disp(x)

    NumeroEtapas = [0:1:N];
    plot(NumeroEtapas, Rend), title('RENDIMIENTO VS ETAPA')
    grid
    xlabel('Numero de etapas')
    ylabel('Rendimiento [%]')
    legend({'Rendimiento'},'Location','southeast')

