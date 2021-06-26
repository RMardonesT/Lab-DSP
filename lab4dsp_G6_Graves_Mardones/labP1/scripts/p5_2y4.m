%%%%% Parte V Lab 4
close all; %clear; clc;

%%% 2) Visualización de matrices DFT
tRe = {'Visualización parte real Matriz DFT N = 8','Visualización parte real Matriz DFT N = 64'}; 
tIm = {'Visualización parte imaginaria Matriz DFT N = 8','Visualización parte imaginaria Matriz DFT N = 64'};
N = [8 64];
for i = [1 2]
    A = genAmatrix(N(i));
    figure
    colormap(hot); imagesc(real(A)); colorbar;
    title(tRe(i))
    figure
    colormap(hot); imagesc(imag(A)); colorbar;
    title(tIm(i))
end

%% 4) Comparación temporal

Fs = 5000; Nx = 5000; t = (0:Nx-1)/Fs;
x = cos(2*pi*100*t); % Señal a analizar

NUMERO = length(100:100:Nx);
delta_fft    = zeros(1,NUMERO);
delta_DFTsum = zeros(1,NUMERO);
delta_dftmtx = zeros(1,NUMERO);


for N = 100:100:Nx
    f = @() fft(x,N);
    t1 = timeit(f);
    
    g = @() DFTsum(x(1:N));
    t2 = timeit(g);
    
    h = @() dftmtx(N);
    t3 = timeit(h); 
    
    delta_fft(N/100)    = t1;
    delta_DFTsum(N/100) = t2;
    delta_dftmtx(N/100) = t3;
end

%%% Visualización
figure
n = 100:100:Nx;
plot(n, log10(delta_fft))
hold on
plot(n, log10(delta_DFTsum)); plot(n, log10(delta_dftmtx))
xlabel("Largo de vector de entrada");
ylabel("Tiempo [s] en escala logaritmica base 10");
title("Comparación entre métodos de cálculo DFT")
legend("fft()", "DFTsum()", "dftmtx()");