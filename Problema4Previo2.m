clear, clc
E = .2;
n = 4;
A = [2 .5 0 0;.5 E .5 0;0 .5 2 .5;0 0 .5 2];
b = [0.1 1 .1 2]';
[L U] = lu(A);
y = zeros(n,1);
x = zeros(n,1);
y(1) = b(1);
for j = 2:n
    y(j) = b(j)-L(j,j-1)*y(j-1);
end
x(n) = y(n)/U(n,n);
for j = n-1:-1:1
    x(j) = (y(j)-U(j,j+1)*x(j+1))/U(j,j);
end
disp('La solución aproximada de Ax=b es:');
disp(x);
disp('');
xx = A\b;
disp('La solución exacta de Ax=b es:');
disp(xx)