function [amp,w] = positiveSpectrum(x)
    X = fft(x);
    amp = X(1:floor(length(X)/2))
    w = linspace(0,pi,length(amp))
    
    
end
