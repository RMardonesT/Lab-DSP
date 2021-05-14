%p5.3
close all; clear; clc

%Se trae vector de datos al workspace
load("aliasing_test_16_16.mat");

%Proceso de Decimación
Q = 4; %Factor de decimacion
aliasing_decima = decima(aliasing_test,Q);

%Gráficos de FFT
N1 = length(aliasing_test); %Puntos de fft
N2 = length(aliasing_decima);

w1 = (-N1/2:N1/2-1)/N1*2*pi;
w2 = (-N2/2:N2/2-1)/N2*2*pi;

ALIASING_TEST = fft(aliasing_test,N1);
ALIASING_DECIMA = fft(aliasing_decima,N2);

figure
subplot 211
plot(w1,fftshift(abs(ALIASING_TEST)));
xlim([-pi pi])
xlabel("Frecuencia Normalizada (rad/muestra)");
ylabel("Amplitud");
title("Espectro de señal alising\_test")

subplot 212
plot(w2,fftshift(abs(ALIASING_DECIMA)));
xlim([-pi pi])
xlabel("Frecuencia Normalizada (rad/muestra)");
ylabel("Amplitud");
title("Espectro de señal alising\_test luego de decimación con Q = 4")