% Metodo iterativo de Jacobi
% Giovanni Calderon oct. 2017


clear, clc
A = [10 1  2  3;
     1  10 2  1;
     2  2  10 0;
     3  1  0  1.1];
b = [1;1;1;1];
x0 = [1;1;1;1];

A = [1  1;
     1 -3];
b = [3;-3];
x0 = [0;0];
A\b
it_lim = 200;
tol = .000001;
[n,m] = size(A);
xnew = zeros(n,1);
error = tol+1;
contador = 0;
while 1
    for i = 1:n
        sum = 0;
        for j = 1:n
            sum = A(i,j)*x0(j)+sum;
        end
        sum = sum - A(i,i)*x0(i);
        xnew(i) = (b(i)-sum)/A(i,i);
    end
    error = max(abs(xnew-x0));
    if error < tol
        fprintf('Se satisface la tolerancia.\n');
        break
    end
    contador = contador+1;
    if(contador > it_lim)
         fprintf('Se excedió límite de iteraciones.\n');
         break
    end
    x0 = xnew;
end
disp(xnew)

