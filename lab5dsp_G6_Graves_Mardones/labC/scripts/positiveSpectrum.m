function [amp,w] = positiveSpectrum(x)
    X = abs(fft(x));
    amp = X(1:floor(length(X)/2)+1)
    w = linspace(0,pi,length(amp))
   
end
