function X = FFT4(x)
    X = zeros(1,4);
    
    x0 = [x(1) x(3)]; %Muestras "pares"
    x1 = [x(2) x(4)]; %Muestras "impares"
    
    X0 = FFT2(x0);
    X1 = FFT2(x1);
    
    X(1) = X0(1) +   (1)*X1(1);
    X(2) = X0(2) + (-1j)*X1(2);    
    
    X(3) = X0(1) -   (1)*X1(1);
    X(4) = X0(2) - (-1j)*X1(2);    
end