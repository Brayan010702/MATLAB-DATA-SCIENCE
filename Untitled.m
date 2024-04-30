%Fenomenos de transporte II, Grupo L2
%Profesor: Duban Garcia
%Estudiantes: Brayan Quitian - 2182467 , Nestor Gomez - 2182449
%Ejercicio 11-48, Cengel punto b
%03/09/2021
clc
clear

%:agua , h : agua geotermica 
Tc1=25; %°C
Tc2=60; %°C
mc=0.2; %kg/s
Cpc=4.18; %Kj/(kg°C)
Cph=4.31; %Kj/(kg°C)
di=0.008; %m
U=0.55; %KW/(m^2°C)

i=1;

for mh=0.1:0.025:0.5
    
    Th1=140; %°C
    
Q(i)=mc*Cpc*(Tc2-Tc1);   
Th2(i)=Th1-Q(i)/(mh*Cph);
dT1(i)=Th1-Tc1;
dT2(i)=Th2(i)-Tc2;
dTlog(i)=(dT1(i)-dT2(i))/log(dT1(i)/dT2(i));
As(i)=Q(i)/(dTlog(i)*U);
L(i)=As(i)/(pi()*di);
Temp(i)=Th1;
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

subplot(2,2,1)
plot(Flujo,L,'LineWidth',2)
xlabel('Flujo de agua (Kg/s)')
ylabel('Longitud del intercambiador (m)') 
      
subplot(2,2,3)
plot(Flujo,e,'Linewidth',2)
xlabel('Flujo de agua (Kg/s)')
ylabel('Eficiencia del intercambiador')