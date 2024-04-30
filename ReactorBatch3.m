% Reactor batch punto 3 - 2182467 - Brayan Steven Quitián Espinosa 
% 05/03/2022 - DISEÑO DE REACTORES - D1.
    clc, clear 
% Reacciones en serie:
% A ---[kB]---> B ---[kC]---> C
%--------------------------------------------------------------------------
caso = input('Escriba el caso de operación: ');
if caso == 1
    kB = 2; kC = 1; i = 1;
    for t=0:0.02:10
        CA(i) = exp(-(kB)*t);
        CB(i) = (kB/(kC-kB))*(exp(-kB*t)-exp(-kC*t));
        CC(i) = (1/(kC-kB))*(kB*(exp(-kC*t)-1)-kC*(exp(-kB*t)-1));
        S(i) = CB(i)/CC(i);
            tiempo(i) = t;
            i = i+1;
    end
%--------------------------------------------------------------------------
elseif caso == 2
    kB = 4; kC = 1; i = 1;
    for t=0:0.02:10
        CA(i) = exp(-(kB)*t);
        CB(i) = (kB/(kC-kB))*(exp(-kB*t)-exp(-kC*t));
        CC(i) = (1/(kC-kB))*(kB*(exp(-kC*t)-1)-kC*(exp(-kB*t)-1));
        S(i) = CB(i)/CC(i);
            tiempo(i) = t;
            i = i+1;
    end
end 
%--------------------------------------------------------------------------
% GRAFICO    
    subplot(1,2,1), hold, plot(tiempo, CA, tiempo, CB, tiempo, CC)
    title('CONCENTRACIÓN VS TIEMPO'), grid 
    xlabel('Tiempo [s]'), ylabel('Concentración [mol/L]')
    legend({'Concentración A','Concentración B', 'Concentración C'},'Location','northeast')

    subplot(1,2,2), hold, plot(tiempo, S)
    title('SELECTIVIDAD VS TIEMPO'), grid 
    xlabel('Tiempo [s]'), ylabel('Selectividad')
    legend({'Selectividad'},'Location','northeast')
