clc
clear variables
%Ejercicio 11-48 enunciado b, Cengel.
%Brayan Steven Quitián Espinosa 2182467 - Nestor Alexis Gómez Celis 2182449
%Fenomenos de transporte II, grupo L2.
%Profesor Duban Garcia
%03/09/2021 

%Datos 
%Datos extra
di=0.008; %m
U=0.55; %kW/(m^2°C)
i=1;

%Agua (c)
Tci=25; %°C
Tce=60; %°C
mc=0.2; %kg/s
Cpc=4.18; %kJ/(Kg°C)

%Agua geotérmica (h)
Thi=140; %°C
Cph=4.31; %kJ/(Kg°C)

for mh=0.1:0.0001:0.5
Q(i)=mc*Cpc*(Tce-Tci);   
The(i)=Thi-Q(i)/(mh*Cph);
dTi(i)=Thi-Tci;
dTe(i)=The(i)-Tce;
dTlog(i)=(dTi(i)-dTe(i))/log(dTi(i)/dTe(i));
As(i)=Q(i)/(dTlog(i)*U);
L(i)=As(i)/(pi()*di);
Temp(i)=Thi;
Flujo(i)=mh;
Cc=Cpc*mc;
Ch=Cph*mh;
Cmin=min([Cc Ch]);
Cmax=max([Cc Ch]);
C=Cmin/Cmax; 
NTU(i)=U*As(i)/Cmin;
e(i)=(1-exp(-NTU(i)*(1+C)))/(1+C);
i=i+1;

end

%Grafica
subplot(2,2,1)
plot(Flujo,L,'LineWidth',2)
xlabel('Flujo de agua geotérmica (Kg/s)')
ylabel('Longitud del intercambiador (m)') 

subplot(2,2,4)
plot(Flujo,e,'LineWidth',2)
xlabel('Flujo de agua geotérmica (Kg/s)')
ylabel('Eficiencia del intercambiador') 
  
subplot(2,2,2)
plot(L,e,'LineWidth',2)
xlabel('Longitud del intercambiador (m)')
ylabel('Eficiencia del intercambiador') 
 