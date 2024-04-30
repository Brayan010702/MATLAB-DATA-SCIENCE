clc
clear
A = [1 2 4;9 2 1;1 0 3]; 
%A = hilb(3);
b = [1;2;3];
t = 17;
k = cond(A);
x = A\b;
r = vpa(b-A*x,64);
y = A\r;
Kest = 5.36870913*(norm(y)/norm(x))*10^t;
%Kest = (norm(y)/norm(x))*10^t;
disp(k);
disp(Kest);



%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
A = [1 2 4;9 2 1;1 0 3]; 
b = [1;2;3];
t = 17;
k = cond(A);
x = vpa(A\b,17);
r = vpa(b-A*x,17);
y = vpa(A\r);
Kest = (norm(y)/norm(x))*10^t;
Kest = double(Kest);
disp(k);
disp(Kest);
%%%%%%%%%%%%%%%%%%%%%%%%%%%555
digits = 3;
a=0.123;
b=0.00004;
a+b
vpa(a+b,3)