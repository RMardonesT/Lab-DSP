clear all; clc;
N = [256,500,2048];
n = 0:1:500;
fs = 5000;

x1 = sin(2*pi*n/50);
x2 = cos(2*pi*n/50);

for i=1:length(N)
    
    %figure(i)
    
    X1 = fftshift(fft(x1,N(i)));
    X2 = fftshift(fft(x2,N(i)));
    
    
    %Magnitud
    mag1 = abs(X1);
    mag2 = abs(X2);
    
    %real
    rX1 = real(X1);
    rX2 = real(X2);
    
    %imag
    iX1 = imag(X1);
    iX2 = imag(X2);
    
    
    
    
  
    
end