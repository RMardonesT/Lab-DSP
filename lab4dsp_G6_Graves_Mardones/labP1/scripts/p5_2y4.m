%%%%% Parte V Lab 4
close all; clear; clc;

%%% 2) Visualización de matrices DFT

for N = [8 64]
    A = genAmatrix(N);
    figure
    colormap(hot); imagesc(real(A));
    %figure; mesh(real(A));
    figure
    colormap(hot); imagesc(imag(A));
    %figure; mesh(imag(A));
end

%%% 4) Comparación temporal

Fs = 5000; Nx = 5000; t = (0:Nx-1)/Fs;
x = cos(2*pi*100*t); % Señal a analizar

delta_fft    = zeros(1,1000-100+1);
delta_DFTsum = zeros(1,1000-100+1);
delta_dftmtx = zeros(1,1000-100+1);

for N = 100:1000
    f = @() fft(x,N);
    delta_fft(N-99) = timeit(f);
    
    g = @() DFTsum(x);
    delta_DFTsum(N-99) = timeit(g);
    
    h = @() dtfmtx(N)*x(1:N);
    delta_dftmtx(N-99) = timeit(h);    
end

% Visualización
figure
n = 100:1000;
plot(n, delta_fft)
hold on
plot(n, delta_DFTsum); plot(n, delta_dftmtx)
xlabel("Largo de vector de entrada");
ylabel("Tiempo [s]");
title("Comparación entre métodos de cálculo DFT")
legend("fft()", "DFTsum()", "dftmtx");