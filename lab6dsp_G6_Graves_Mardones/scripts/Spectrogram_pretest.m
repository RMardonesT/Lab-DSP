%%%%%%% Lab 6 DSP - Test Phaser
close all; clear; clc;

%%%%% 1. Parámetros
%%% Muestreo
fs = 8000; Ts = 1/fs;

%%% Espectrograma
T_spect = 0.1; 

%%% Señal aleatoria
T_sa = 5; 


%%%%% 2. Generación de señal aleatoría
x = randn(1,round(fs*T_sa));

%%%%% 3. Obtención de espectrograma
figure
spectrogram(x, round(T_spect*fs));
