function A=Regresion(x,y)
i = 1;
r = 0;

while r < 1
    a = polyfit(x,y,i);
        yfit = polyval(a,x);
        yresid = y - yfit;
        SSresid = sum(yresid.^2);
        SStotal = (length(y)-1)*var(y);
        rsq = 1 - SSresid/SStotal;
        r = round(rsq, 1);
        i = i+1;    
end

GradoPol = i - 1;

if GradoPol == 1
a0 = round(a(2),4); a1 = round(a(1),4);
a2 = 0; a3 = 0; a4 = 0; a5 = 0;
elseif GradoPol == 2
a0 = round(a(3),4); a1 = round(a(2),4); a2 = round(a(1),4);
a3 = 0; a4 = 0; a5 = 0;
elseif GradoPol == 3
a0 = round(a(4),4); a1 = round(a(3),4); a2 = round(a(2),4); a3 = round(a(1),4); 
a4 = 0; a5 = 0;
elseif GradoPol == 4
a0 = round(a(5),4); a1 = round(a(4),4); a2 = round(a(3),4); a3 = round(a(2),4); a4 = round(a(1),4); 
a5 = 0;
elseif GradoPol == 5
a0 = round(a(6),4); a1 = round(a(5),4); a2 = round(a(4),4); a3 = round(a(3),4); a4 = round(a(2),4); a5 = round(a(1),4);
end


if a1 == a2 == a3 == a4 == a5 == 0
    k = a(1);
    x = ['La retención es constante, donde N = ', num2str(k)];
    disp(x)
elseif a0 == -1*a1 
    beta = a(2);
    x = ['La variacion es constante, donde N = ', num2str(beta),'(1-x)'];
    disp(x)
else
    A=a(i:-1:1);
    x = ['La variacion es variable, donde N = ', num2str(a0),'+', num2str(a1),'+x', num2str(a2),'+x^2', num2str(a3),'+x^3', num2str(a4),'+x^4', num2str(a5),'+x^5'];
    disp(x)
end

end






