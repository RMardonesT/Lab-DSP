%%%%% Parte V Lab 4
close all; clear; clc;

%%% 2) Visualización de matrices DFT
tRe = {'Visualización parte real Matriz DFT N = 8','Visualización parte real Matriz DFT N = 64'}; 
tIm = {'Visualización parte imaginaria Matriz DFT N = 8','Visualización parte imaginaria Matriz DFT N = 64'};
N = [8 64];
for i = [1 2]
    A = genAmatrix(N(i));
    figure
    colormap(hot); imagesc(real(A));
    title(tRe(i))
    figure
    colormap(hot); imagesc(imag(A));
    title(tIm(i))
end

%%% 4) Comparación temporal

Fs = 5000; Nx = 5000; t = (0:Nx-1)/Fs;
x = cos(2*pi*100*t); % Señal a analizar

delta_fft    = zeros(1,1000-100+1);
delta_DFTsum = zeros(1,1000-100+1);
delta_dftmtx = zeros(1,1000-100+1);


for N = 100:1000
    f = @() fft(x,N);
    t1 = timeit(f);
    
    g = @() DFTsum(x);
    t2 = timeit(g);
    
    h = @() DFTmatrix(N)*x(1:N);
    t3 = timeit(h); 
    
    delta_fft(N-99)    = t1;
    delta_DFTsum(N-99) = t2;
    delta_dftmtx(N-99) = t3;
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