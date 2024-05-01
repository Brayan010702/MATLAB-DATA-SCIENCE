clear, clc 
iter = 20000;
tol  = 10^(-12);
% A = [1 01 1 2;3 4 2 5;1 0 1 5;1 2 4 3];
n = 6;
A = hilb(n);
b = 1:1:n;
b = b';
x0 = ones(n,1);

[L,U] = lu(A);
for j = 1:iter
   r = b-A*x0;
   delta = A\r;
   x1 = delta+x0;
   if norm(x1-x0)/norm(x1)<tol
       disp(x1);
       break
   else
       x0=x1;
   end
end
j
real=A\b;
iterado=x1;
real-iterado
