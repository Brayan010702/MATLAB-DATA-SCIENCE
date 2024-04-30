% Actividad 4 - Reactor con chaqueta - 2182467 - Brayan Steven Quitián 
% Espinosa 
% 25/01/2022 - Ingenieria computacional - H1.
    clc
    clear
% Un reactor tipo tanque perfectamente agitado, ocurre una reacción química 
% altamente exotérmica, donde la temperatura se controla por un sistema de 
% tanque enchaquetado (circula un líquido entre la parte externa del 
% reactor y la chaqueta), para mantener la temperatura en el reactor 
% uniforme.

% Determine:
% 1.	Balance de masa y energía (Ecuaciones diferenciales) (Se deben 
% entregar al terminar la clase del 20 de enero 2022)
% 2.	Calcule la temperatura T y la concentración Ca de la corriente 
% de salida cuando el reactor trabaja a régimen transitorio y hasta 
% alcanzar el régimen permanente para el caso de una reacción de primer 
% orden. Condiciones iniciales: CA (0) = 5 mol/L y T(0) = 300 K.


% ECUACIÓN PARA BALANCE DE MASA CON REACCION POR COMPONENTE (A):
    % A = Entrada - Salida + Genera - Consume
    % dCa/dt = (F/V)(Ca0)-(F/V)(Ca)-kCa

% ECUACIÓN PARA BALANCE DE ENERGIA CON REACCION POR COMPONENTE (A):
    % dE/dt = Ee - Es
    % dT/dt = (F/V)(To-T)-(dH*k*Ca/rho*Cp)-(U*As/rho*V*Cp)(T-Tj)

% VALORES INICIALES DEL PROBLEMA
    F = 0.01;                                   %L/s
    V = 2;                                      %L
    Ca0 = 5;                                    %mol/L
    %k = (8*10^12)*exp(-22500/(1.987*T));       %s^-1
    T0 = 300;                                   %k
    dH = -10000;                                %cal/gmol
    U = 100;                                    %cal/°Csm^2
    A = 0.02;                                   %m^2
    Tj = 330;                                   %k
    rho = 1;                                    %kg/L
    Cp = 1000;                                  %kcal/kg*°C
    
% RUNGE KUTTA ORDEN 4 -----------------------------------------------------
    h = 1; t = 0:h:3600; n = length(t);
    x = Ca0; y = T0;
    for i=1:n-1
        k1 = h*((F/V)*(Ca0)-(F/V)*(x(i))-((8*10^12)*exp(-22500/(1.987*y(i))))*(x(i)));
        l1 = h*((F/V)*(T0-y(i))-((dH*x(i)*((8*10^12)*exp(-22500/(1.987*y(i)))))/(rho*Cp))-((U*A)/(rho*V*Cp))*(y(i)-Tj));
        k2 = h*((F/V)*(Ca0)-(F/V)*((x(i)+k1/2))-((8*10^12)*exp(-22500/(1.987*(y(i)+l1/2))))*((x(i)+k1/2)));
        l2 = h*((F/V)*(T0-(y(i)+l1/2))-((dH*(x(i)+k1/2)*((8*10^12)*exp(-22500/(1.987*(y(i)+l1/2)))))/(rho*Cp))-((U*A)/(rho*V*Cp))*((y(i)+l1/2)-Tj));
        k3 = h*((F/V)*(Ca0)-(F/V)*((x(i)+k2/2))-((8*10^12)*exp(-22500/(1.987*(y(i)+l2/2))))*((x(i)+k2/2)));
        l3 = h*((F/V)*(T0-(y(i)+l2/2))-((dH*(x(i)+k2/2)*((8*10^12)*exp(-22500/(1.987*(y(i)+l2/2)))))/(rho*Cp))-((U*A)/(rho*V*Cp))*((y(i)+l2/2)-Tj));
        k4 = h*((F/V)*(Ca0)-(F/V)*((x(i)+k3))-((8*10^12)*exp(-22500/(1.987*(y(i)+l3))))*((x(i)+k3)));
        l4 = h*((F/V)*(T0-(y(i)+l3))-((dH*(x(i)+k3)*((8*10^12)*exp(-22500/(1.987*(y(i)+l3)))))/(rho*Cp))-((U*A)/(rho*V*Cp))*((y(i)+l3)-Tj));
        x(i+1) = x(i)+(1/6)*(k1+2*k2+2*k3+k4);
        y(i+1) = y(i)+(1/6)*(l1+2*l2+2*l3+l4);
    end
%--------------------------------------------------------------------------

% GRAFICA
    subplot(1,2,1),plot(t,x), title('CONCENTRACIÓN VS TIEMPO')
    grid
    xlabel('Tiempo [s]')
    ylabel('Concentración [mol/L]')
    legend({'Concentración A', 'Temperatura'},'Location','northeast')

    subplot(1,2,2),plot(t,y), title('TEMPERATURA VS TIEMPO')
    grid
    xlabel('Tiempo [s]')
    ylabel('Temperatura [k]')
    legend({'Temperatura', 'Concentración A'},'Location','southeast')

% TABLA    
    Concentracion_A = reshape(x,[n,1]);
    Temperatura = reshape(y,[n,1]);
    Tiempo = reshape(t,[n,1]);
    table(Tiempo, Concentracion_A, Temperatura)

% FIN