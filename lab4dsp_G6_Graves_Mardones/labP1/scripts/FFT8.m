function X = FFT8(x)
    X = zeros(1,8);
    
    x0 = [x(1) x(3) x(5) x(7)]; %Muestras "pares"
    x1 = [x(2) x(4) x(6) x(8)]; %Muestras "impares"
    
    X0 = FFT4(x0);
    X1 = FFT4(x1);
    
    X(1) = X0(1) +               (1)*X1(1);
    X(2) = X0(2) +   (exp(-1j*pi/4))*X1(2);
    X(3) = X0(3) +             (-1j)*X1(3);
    X(4) = X0(4) + (exp(-1j*3*pi/4))*X1(4);
    
    X(5) = X0(1) -               (1)*X1(1);
    X(6) = X0(2) -   (exp(-1j*pi/4))*X1(2);
    X(7) = X0(3) -             (-1j)*X1(3);
    X(8) = X0(4) - (exp(-1j*3*pi/4))*X1(4);
end