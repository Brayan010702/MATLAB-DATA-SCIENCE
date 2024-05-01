A = [.5  .25;
     .25 -.25];
b = [1;-1];
x0 = [0;0];
x1 = A\b
B = [0 -.5;-1 0];
d = [2;4];
sol = [x0];
for j = 1:35
  x1 = B*x0+d;
  sol = [sol x1];
  x0 = x1;
end
sol
x=sol(1,:);
y=sol(2,:);
plot(x,y)
