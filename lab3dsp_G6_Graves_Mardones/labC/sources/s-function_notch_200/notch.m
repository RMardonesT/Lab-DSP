function [a, b, d_2] = notch(BW, theta)    
    %Polinomio:
    p = [cos(BW) -2 cos(BW)];
    d_2 = roots(p);
    
    %Elección de dn
    if (abs(d_2(2))<abs(d_2(1)))
        d = d_2(2);
    else
        d = d_2(1);
    end
    
    % Obtención de retornos
    b = (1+d)/2*[1 -2*cos(theta) 1];
    a = [1 -(1+d)*cos(theta) d];
end