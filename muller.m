% Metodo de Muller
function[xr, T]=muller(f,xr,h,c,e)
% Crear función a partir del parametro texto 
fx=inline(f);
% Crear los 3 puntos a partir del parametro 
x2=xr;
x1=xr+h;
x0=xr-h;
% Inicializar variables auxiliares
k=0;
sigue=1;
T=[0 0 0 0];
% Crear iterativo para determinar la raiz 
while(sigue)
    % Contador de ciclos
    k=k+1;
    % Calcular a, b, y c
    h0=x1-x0;
    h1=x2-x1;
    d0=(fx(x1)-fx(x0))/h0;
    d1=(fx(x2)-fx(x1))/h1;
    a=(d1-d0)/(h1+h0);
    b=a*h1+d1;
    c=fx(x2);
    % Obtener la raiz de la ecuación general
    raizd=sqrt(b*b-4*a*c);
    % Determinar el valor más grande 
    if abs(b+raizd)>abs(b-raizd)
        den=b+raizd;
    else
        den=b-raizd;
    end
    % Calcular el siguiente valor 
    dxr=-2*c/den;
    xr=x2+dxr;
    % Validar si continua el metodo
    sigue=abs(dxr)/xr>e||k<c||abs(fx(xr))>e;
    % Hacer el cambio de variables 
    x0=x1; 
    x1=x2;
    x2=xr;
    % Guardar en la matriz de iteraciones 
    T(k,:)=[x0 x1 x2 fx(xr)];
    % Terminar el ciclo 
end
% Validar si converge 
if k==c
    xr='No converge';
end

    
    