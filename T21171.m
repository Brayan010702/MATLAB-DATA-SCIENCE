clc
clear variables
%Ejercicio 11-71, Cengel.
%Brayan Steven Quitián Espinosa 2182467 - Nestor Alexis Gómez Celis 2182449
%Fenomenos de transporte II, grupo L2.
%Profesor Duban Garcia
%03/09/2021 

syms Q Tln Thi The mh Tci Tce hfg Cph mc U As

%Datos
%Extra
U=1.780; %kW/m^2°C
As=0.5; %m^2

%Agua (c)
Tci=200; %°C
Tce=200; %°C
hfg=1941; %KJ/Kg

%Gas (h)
Cph=1.051; %KJ/Kg°C
mh=0.25; %Kg/s
i=1;

for Thi=300:15:600;

e1 = Tln==(The-Thi)/log((The-Tce)/(Thi-Tci));
e2 = Q==U*As*Tln;
e3 = Q==mh*Cph*(Thi-The);
e4 = Q==mc*hfg;

sol = solve([e1 e2 e3 e4], [Tln Q The mc]);

    a(i)=[sol.Tln];
    b(i)=[sol.Q];
    c(i)=[sol.The];
    d(i)=[sol.mc];
    Temp(i)=Thi;
    i=i+1;
end

%Graficas
subplot (1,3,1)
plot(Temp,b,'y','LineWidth',2)
xlabel('Temperatura de entrada del gas [°C]');
ylabel('Calor [KW]');
   
subplot(1,3,2)
plot(Temp,c,'b','LineWidth',2)
xlabel('Temperatura de entrada del gas [°C]');
ylabel('Temperatura de salida del gas [°C]');
   
subplot(1,3,3)
plot(Temp,d,'r','LineWidth',2)
xlabel('Temperatura de entrada del gas [°C]');
ylabel('Rapidez de evaporación [Kg/s]');   

    