%% Generación de señales
close all; clear; clc;
%1
fs = 2000  ; %2kHz, sobre frecuencia de nyquist
N  = 2000*1; %fs * Tiempo de duración
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

soundsc(s50,fs);
soundsc(s500,fs);