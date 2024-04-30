% ELIMINACION GAUSSIANA CON PIVOTEO PARCIAL (SOLUCION POR ETAPAS)

clc, clear  

fprintf('ELIMINACION GAUSSIANA CON PIVOTEO PARCIAL\n\n\n');
A = input('Ingrese la matriz A = \n');
b = input('\nIngrese el vector b, correspondite a los terminos independientes b=\n');
%permite obtener el tamaño de la matriz A
[n,m] = size(A);
C = [A,b]; % C representa la forma de la matriz aumentada [A b]

fprintf('\n La Matriz C, que corresponte a la matriz aumentada [Ab] es = \n');
disp(C);  

if n == m %compara el numero de columnas y filas, para observar si son iguales
    for k = 1:(n-1)
        fprintf('\n ETAPA %g=\n\n',k)
        mayor = 0; %asigna como cero el numero mayor de la fila
        filam = k; %asigna la fila k como la columna que tiene el numero mayor
        for p = k:n
            if mayor < abs(C(p,k)) %se busca el numero mayor en la fila K
               mayor = abs(C(p,k));%cambio de mayor
               filam = p; %cambio de fila
            end
        end
        if mayor == 0
            fprintf('\nEl sistema tiene infinitas soluciones\n')
            break % se interrumpe el programa, ya que si mayor = 0, mas 
                  % adelante se obtiene una division por cero
        else
            if filam ~= k 
                for j = 1:(n+1)
                    aux = C(k,j);% se utilizamos una variable auxiliar para poder
                    % intercambiar la fila
                    C(k,j) = C(filam,j);
                    C(filam,j) = aux;
                end
            end
        end
        fprintf('\n La matriz correspondiente a esta etapa antes del proceso:\n')
        disp(C)
        fprintf('\n Los Multiplicadores correpondientes a esta etapa son:\n')
        for i = (k+1):n
            m(i,k) = C(i,k)/C(k,k); %formula multiplicadores
            fprintf('\n m(%g,%g)=',i,k)
            disp(m(i,k));
            for j = k:(n+1)
                C(i,j) = C(i,j) - m(i,k)*C(k,j);%formula nueva fila
            end
        end
        fprintf('\n La matriz correspondiente a esta etapa despues del proceso:\n')   
        disp(C)
    end
    for i = n:-1:1
        suma = 0;
        for p = (i+1):n
            suma = suma + C(i,p)*X(p);
        end
        X(i) = (C(i,n+1)-suma)/C(i,i);  % formula de la susticion regresiva
    end
else 
     fprintf('\n ERROR: La matriz NO es cuadrada\n');
end
fprintf('\n\n SOLUCION:\n');
fprintf('\n\nLa matriz Ab final:\n');
disp(C)
fprintf('\n\n La solucion del sistema Ax=b es:\n');
disp(X)

