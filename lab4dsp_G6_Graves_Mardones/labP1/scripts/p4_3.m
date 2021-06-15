%%%%% Parte IV Lab 4
close all; clear; clc;

%%% 3) Comparación DFTsum() con fft() para 500 puntos
Fs = 5000; N = 5000; t = (0:N-1)/Fs;

x = cos(2*pi*100*t); % Señal a analizar

% Obtención de espectros y error espectral
f = (0:N-1)*Fs/N;
X_DFTsum = DFTsum(x); 
X_fft    = fft(x,N);

e   = X_DFTsum - X_fft;

format long
X_mse = sum(abs(e).^2)/N

%Gráficos
plot(f,abs(e));
title("Magnitud del Error del espectro, calculado con DFTsum y fft")
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");