%%%%% Parte VI Lab 4 DSP
function X = FFT2(x)
    X = zeros(1,2);
    
    X(1) = x(1) + x(2);
    X(2) = x(1) - x(2);
end