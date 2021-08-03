%%%%%%% Lab 6 DSP - Test Phaser
close all; clear; clc;

%%%%% 0. Importación de señal
file1 = 'soplo_rodrigo.wav';
file2 = 'soplo_rodrigo_phaser.wav';

[data1, fs1] = audioread(file1);
[data2, fs2] = audioread(file2);

%%%%% 1. Parámetros
%%% Muestreo
T_spect = 0.05; 

%%%%% 2. Obtención de espectrogramas
figure
spectrogram(data1', round(T_spect*fs1), 'yaxis');

figure
spectrogram(data2(:,1)', round(T_spect*fs2), 'yaxis');

figure
spectrogram(data2(:,2)', round(T_spect*fs2), 'yaxis');