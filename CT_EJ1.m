% Ejemplo 1 - Concentracion tanques - 2182467 - Brayan Steven Quitián 
% Espinosa 
% 15/12/2021 - Ingenieria computacional - H1.
    clc
    clear
% A nivel industrial el mezclado es importante durante el proceso de 
% reacción, sin embargo, en algunas ocasiones se tienen problemas en 
% alcanzar un mezclado perfecto. Para modelar este tipo de situaciones se 
% puede utilizar dos o más reactores con recirculación entre ellos, como 
% se muestra en la figura. 

% En este sistema se lleva a cabo una reacción isotérmica irreversible del 
% tipo de orden 1,8 con respecto al reactante A. con los datos 
% suministrados, calcule la concentración del reactante A en los reactores 
% 1 y 2 (CA1 y CA2, respectivamente) durante el tiempo necesario para 
% alcanzar el régimen permanente.

% ECUACIÓN PARA BALANCE DE REACCION POR COMPONENTE (A):
    % A = Entrada - Salida + Genera - Consume
    % dCa1/dt = (F/V1)(Ca0-Ca1)+(Fr/V1)(Ca2-Ca1)-kCa1^(1.8)
    % dCa2/dt = ((F+Fr)/V2)(Ca1-Ca2)-kCa2^(1.8)

% VALORES INICIALES DEL PROBLEMA
    F = 25;                     %L/min
    Fr = 100;                   %L/min
    Ca0 = 1;                    %mol/L
    k = 0.2;                    %(L/mol)^0.8*min^-1
    V1 = 80;                    %L
    V2 = 20;                    %L
    Ca10 = 0;                   %mol/L 
    Ca20 = 0;                   %mol/L

% RUNGE KUTTA ORDEN 4 -----------------------------------------------------
    h = 0.2; t = 0:h:60; n = length(t);
    x = Ca10; y = Ca20;
    for i=1:n-1
        k1 = h*((F/V1)*(Ca0-x(i))+(Fr/V1)*(y(i)-x(i))-k*(x(i)^(1.8)));
        l1 = h*(((F+Fr)/V2)*(x(i)-y(i))-k*(y(i)^(1.8)));
        k2 = h*((F/V1)*(Ca0-(x(i)+k1/2))+(Fr/V1)*((y(i)+l1/2)-(x(i)+k1/2))-k*((x(i)+k1/2)^(1.8)));
        l2 = h*(((F+Fr)/V2)*((x(i)+k1/2)-(y(i)+l1/2))-k*((y(i)+l1/2)^(1.8)));
        k3 = h*((F/V1)*(Ca0-(x(i)+k2/2))+(Fr/V1)*((y(i)+l2/2)-(x(i)+k2/2))-k*((x(i)+k2/2)^(1.8)));
        l3 = h*(((F+Fr)/V2)*((x(i)+k2/2)-(y(i)+l2/2))-k*((y(i)+l2/2)^(1.8)));
        k4 = h*((F/V1)*(Ca0-(x(i)+k3))+(Fr/V1)*((y(i)+l3)-(x(i)+k3))-k*((x(i)+k3)^(1.8)));
        l4 = h*(((F+Fr)/V2)*((x(i)+k3)-(y(i)+l3))-k*((y(i)+l3)^(1.8)));
        x(i+1) = x(i)+(1/6)*(k1+2*k2+2*k3+k4);
        y(i+1) = y(i)+(1/6)*(l1+2*l2+2*l3+l4);
    end
%--------------------------------------------------------------------------

% GRAFICA
    plot(t,x,t,y)
    grid
    title('CONCENTRACIÓN VS TIEMPO')
    xlabel('Tiempo [min]')
    ylabel('Concentración [mol/L]')
    legend({'Concentración A1', 'Concentración A2'},'Location','southeast')

% TABLA    
    Concentracion_A1 = reshape(x,[n,1]);
    Concentracion_A2 = reshape(y,[n,1]);
    Tiempo = reshape(t,[n,1]);
    table(Tiempo, Concentracion_A1, Concentracion_A2)

% FIN