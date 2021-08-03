%%%%%%% Lab 6 DSP - Test Phaser
close all; clear; clc;

%%%%% 0. Importación de señal
file = 'soplo_richi.ogg';
[data, fs] = audioread(file);
data_r = data(:,1); data_l = data(:,2); 

%%%%% 1. Parámetros
%%% Muestreo
Ts = 1/fs;
T_spect = 0.1; 

%%%%% 2. Obtención de espectrograma
figure
spectrogram(data_r', round(T_spect*fs), 'yaxis');
figure
spectrogram(data_l', round(T_spect*fs), 'yaxis');