n = 3;
A = hilb(n);
% A = [6 2 1;2 4 1;1 1 4]
%A=[10 2 3;2 10 5;3 5 10];
l = zeros(n,n);
for i = 1:n
    suma1 = 0;
    for k = 1:i-1
        suma1 = suma1 + l(i,k)^2;
    end
    l(i,i) = sqrt(A(i,i)-suma1);
    for j = i+1:n
        suma2 = 0;
        for k=1:i-1
            suma2 = suma2+l(i,k)*l(j,k);
        end
        l(j,i) = (A(i,j)-suma2)/l(i,i);
    end
end
disp(l)


