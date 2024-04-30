% Actividad 2 - Tanques - 2182467 - Brayan Steven Quitián Espinosa 
% 02/12/2021 - Ingenieria computacional - H1.
    clc
    clear
% Se tiene un tanque en forma de cilíndrico de radio de 3 m y altura 6m, 
% con cierta cantidad de un fluido de densidad ρ. Al tanque ingresa una 
% corriente de F1 = 4m3/h del mismo componente. El flujo de salida por 
% orificio del fondo es 0,0460 ∗ √ℎ L/s y tiene una salida lateral regulado 
% por una válvula, donde el flujo depende de la caída de presión a través
% del accesorio de acuerdo con la siguiente ecuación 𝑓𝑠 = 0,0025√∆𝑃

% ECUACIÓN PARA LLENADO DE UN TANQUE
%   (4/pi*D^2)(Fe-Fs)dt = dh
%   (4/pi*D^2)(F1-F2-F3)t = h

% VALORES INICIALES
% Codigo 2182467 - perturbación del 17 %
    F1 = 4+4*0.17;                             %[m^3/h] 
    D = 6;                                     %[m]
    g = 9.8;                                   %[m/s^2]
    rho = 1000;                                %[kg/m^3]
    %h0 = (4/(0.1656 + 0.0025*sqrt(rho*g)))^2;%[m]
    h0 = 4;                                    %[m]
    F2 = 0.1656*sqrt(h0);                      %[m^3/h] 
    F3 = 0.0025*sqrt(g*rho*h0);                %[m^3/h] 

% METODO DE EULER   
    htanq = 6;              %[m]
    t0 = 0;                 %[h]
    tf = 1.30;              %[h]
    n = input('Ingrese el numero de datos que desea utilizar (n): ');
    dt = (tf-t0)/n;

% FOR
    t(1) = t0;
    h(1) = h0;
    v(1) = "No";
    for i = 1:n
        t(i+1) = t(i) + dt;
        h(i+1) = h(i)+((4/(pi()*(D)^2))*(F1-F2-F3))*dt;
    end

    for i = 1:n
        if h(i+1) > htanq
            v(i+1) = "Si";
        else 
            v(i+1) = "No";
        end
    end

% CONDICIONAL PARA SABER SI EL TANQUE SE DERRAMA
    if h(i+1) > htanq
        disp('El tanque presenta derrame')
    else 
        disp('El tanque NO presenta derrame')
    end
    
% DETERMINAR SI EL TANQUE SE DERRAMA 
    Hd0 = 0;                        %[m]
    Hf = 6;                         %[m]
    td(1) = t0;
    Hd(1) = Hd0;
    dHd = (Hf-Hd0)/n;
    for i = 1:n
        Hd(i+1) = Hd(i) + dHd;
        td(i+1) = td(i)+((pi()*(D)^2)/(4*(F1-F2-F3)))*dHd;
    end
% GRAFICA
    plot(t,h)
    grid
    title('Variación de la altura del tanque')
    xlabel('Tiempo [h]')
    ylabel('Alutra del tanque [m]')

% TABLA
    tde = td(n+1);
    x = ['El tiempo en el que el tanque se derrama es de: ', num2str(tde), ' horas'];
    disp(x)
    Tiempo = reshape(t,[n+1,1]);
    Altura = reshape(h,[n+1,1]);
    Derrame = reshape(v,[n+1,1]);
    table(Tiempo, Altura, Derrame)
