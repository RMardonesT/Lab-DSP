%p5.3
close all; clear; clc

%Se trae vector de datos al workspace
load("aliasing_test_16_16.mat");

%P y Q para pasar de 16k a 12k
Q = 4; %Factor de decimacion
P = 3; %Factor de interpolación

%Proceso de Decimación 
aliasing_16_4 = decima(aliasing_test,Q);

%Proceso de Interpolación
aliasing_16_12 = interpola(aliasing_16_4,P);

%FFT 
N1 = length(aliasing_test); %Puntos de fft
N2 = length(aliasing_16_12);

w1 = (-N1/2:N1/2-1)/N1*2*pi;
w2 = (-N2/2:N2/2-1)/N2*2*pi;

ALIASING_TEST = fft(aliasing_test,N1);
ALIASING_16_12 = fft(aliasing_16_12,N2);

%Gráficos de FFT
figure
subplot 211
plot(w1,fftshift(abs(ALIASING_TEST)));
xlim([-pi pi])
xlabel("Frecuencia Normalizada (rad/muestra)");
ylabel("Amplitud");
title("Espectro de señal alising\_test a 16 kHz")

subplot 212
plot(w2,fftshift(abs(ALIASING_16_12)));
xlim([-pi pi])
xlabel("Frecuencia Normalizada (rad/muestra)");
ylabel("Amplitud");
title("Espectro de señal alising\_test luego de resampling a 12 kHz")

Fs = 12000;
A = max(abs(aliasing_16_12));
audiowrite('aliasing_test_16_12.wav',aliasing_16_12/A,Fs);