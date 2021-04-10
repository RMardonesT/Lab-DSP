%% Generación de señales
close all; clear; clc;

%1
%  Se crean s50 y s500 (senos de 50 y 500 Hz) y se muestrean a 2500Hz,
%luego se grafican con respecto al tiempo y se escuchan.

fs = 4000; %4kHz, sobre frecuencia de nyquist
N  = fs*1; %fs * Tiempo de duración
n  = 0:N-1 ; %Vector de muestras

s50  = sin(2*pi*(50/fs)*n) ; %señal de 50Hz muestreada a fs
s500 = sin(2*pi*(500/fs)*n); %señal de 500Hz muestreada a fs

figure(1)
subplot 211
plot(n/fs,s50); xlim([0 0.1]);
xlabel("tiempo s");ylabel("Amplitud");title("Señal s_{50}(t) vs tiempo")
subplot 212
plot(n/fs,s500); xlim([0 0.1]);
xlabel("tiempo s");ylabel("Amplitud");title("Señal s_{500}(t) vs tiempo")

%soundsc(s50,fs);
%soundsc(s500,fs);

%2
%  Se generan y se escuchan:
%     - s21: suma de seno de 50 y 500 Hz
%     - s22: suma de seno de 200 y 300 Hz
%     - A  : Acorde La mayor, suma de seno de 880,1100 y 1320 Hz
s21 = s50+s500;
figure(2)
subplot 311
plot (n/fs,s21); xlim([0 0.05]);
xlabel("tiempo s");ylabel("Amplitud");
title("s_{50}(t) + s_{500}(t)  vs tiempo")
%soundsc(s21,fs);

subplot 312
s22 = sin(2*pi*(200/fs)*n) +sin(2*pi*(300/fs)*n);
plot (n/fs,s22); xlim([0 0.05]);
xlabel("tiempo s");ylabel("Amplitud");
title("s_{200}(t) + s_{300}(t)  vs tiempo")
%soundsc(s22,fs);

subplot 313
A = sin(2*pi*(880/fs)*n) +sin(2*pi*(1100/fs)*n)+sin(2*pi*(1320/fs)*n);
plot (n/fs,A); xlim([0 0.05]);
xlabel("tiempo s");ylabel("Amplitud");
title("s_{880}(t) + s_{1100}(t) + s_{1320}(t) vs tiempo")
%soundsc(A,fs);