function Co = Regresion(xNR,yNR)
xNR = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7];
yNR = [5/2 100/41 50/21 100/43 20/9 100/47 100/49 25/13];
i = 1;
r = 0;
% SOLUCION PARA OBTENER LA REGRESION Y EL MEJOR R2
    while r < 1
        a = polyfit(xNR,yNR,i);
            yfit = polyval(a,xNR);
            yresid = yNR - yfit;
            SSresid = sum(yresid.^2);
            SStotal = (length(yNR)-1)*var(yNR);
            rsq = 1 - SSresid/SStotal;
            r = round(rsq, 1);
            i = i+1;    
    end
    GradoPol = i - 1;

% SOLUCION PARA DEFINIR LOS COEFICIENTES A UN POLINOMIO DE GRADO 5
    if GradoPol == 1
        Co = a(i:-1:1);
        Co(3) = 0; Co(4) = 0; Co(5) = 0; Co(6) = 0;
    elseif GradoPol == 2
        Co = a(i:-1:1);
        Co(4) = 0; Co(5) = 0; Co(6) = 0;
    elseif GradoPol == 3
        Co = a(i:-1:1);
        Co(5) = 0; Co(6) = 0;
    elseif GradoPol == 4
        Co = a(i:-1:1);
        Co(6) = 0;
    elseif GradoPol == 5
        Co = a(i:-1:1);
    end

% RESPUESTA, DEFINIR EL TIPO DE RETENCION CONSTANTE O VARIABLE
    Co0 = round(Co(1),4);
    Co1 = round(Co(2),4);
    if Co(2) == Co(3) == Co(4) == Co(5) == Co(6) == 0
        k = Co(1);
        res = ['La retención es constante, donde N = ', num2str(k)];
        disp(res)
    elseif Co0 == -1*Co1 
        beta = Co(1);
        res = ['La retención es constante, donde N = ', num2str(beta),'(1-x)'];
        disp(res)
    else
        res = ['La retención es variable, donde N = ', num2str(Co(1)),'+', num2str(Co(2)),'+x', num2str(Co(3)),'+x^2', num2str(Co(4)),'+x^3', num2str(Co(5)),'+x^4', num2str(Co(6)),'+x^5'];
        disp(res)
    end
end






