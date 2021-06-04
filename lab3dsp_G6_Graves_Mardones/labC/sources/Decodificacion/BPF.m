format long
fs = 16000;
Bw = 2*pi*20/fs;
theta = 2*pi*697/fs;
[a,b] = BPF(Bw,theta)


function [a, b] = BPF(BW, theta)    
    
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
    b = (1+d)/2*[1 0 1];
    a = [1 -(1+d)*cos(theta) d];
end