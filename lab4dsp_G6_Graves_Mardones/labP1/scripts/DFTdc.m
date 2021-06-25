%%%%% Parte VI Lab 4 DSP
function X = DFTdc(x)
    N = length(x);
    W = exp(-1j*2*pi/N);
    Wk = W.^(0:(N/2-1));
    
    x0   = zeros(1,N/2);
    x1 = zeros(1,N/2);
    
    for i = 1:N/2
        x0(i) = x(2*i-1); %OBS "par"   1,3,5,... en MATLAB
        x1(i) = x(2*i);   %OBS "impar" 2,4,6,... en MATLAB       
    end
    
    X0 = DFTsum(x0); X1 = DFTsum(x1);
    
    X_izq = X0 + Wk.*X1;
    X_der = X0 - Wk.*X1;
    
    X = [X_izq X_der];    
end