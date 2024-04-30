clc
a = 3+rand(1000000,1);
b = 1+rand(1000000,1);
c = 1-rand(1000000,1);

a = [3 3.2 3.1 2.9 3]'; b = [1 0.9 0.8 0.9]'; c = [2 2.1 2.3 0.7]'; d = [1 2 3 4 5];
A = [3 2 0 0 0;1 3.2 2.1 0 0;0 0.9 3.1 2.3 0;0 0 0.8 2.9 0.7;0 0 0 .9 3];
x1=A\d';
% A = diag(a,0)+diag(b,-1)+diag(c,1);
% [L1,U1] = lu(A);
n = length(a);
alpha = zeros(1,n);
beta = zeros(1,n);
alpha(1) = a(1);
b = [0; b];
for k = 2:n
    beta(k)=b(k)/alpha(k-1);
    alpha(k)=a(k)-beta(k)*c(k-1);
end

% L = diag(ones(1,n))+diag(beta(2:n),-1);
% U = diag(alpha,0)+diag(c,1);

%%%
%Resolviendo el sistema tridiagonal Ax=d
d = 1:1:1000000;
d = d';
y = zeros(n,1); x = zeros(n,1);
y(1) = d(1);
for i = 2:n
    y(i) = d(i)-beta(i)*y(i-1);
end
x(n) = y(n)/alpha(n);
for i = n-1:-1:1
    x(i) = (y(i)-c(i)*x(i+1))/alpha(i);
end
% x1 = A\d;
 [x x1]

plot(d,x)


     3.500303261129743e+06

ans =
     1.500265579829035e+06

ans =
     4.997722714718888e+05























