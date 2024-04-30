clear, clc
A = hilb(10);
%b =[0 0 0 0 0 0 0 0 0 .1]';
b = ones(10,1);
x0 = .1*ones(10,1);
it_lim = 2000;
tol = .0001;
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
