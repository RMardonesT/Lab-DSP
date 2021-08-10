%%%%%%% Lab 6 DSP - Test Phaser
close all; clear; clc;

%%%%% 0. Importación de señales
load phaser.mat;
data1 = audioData; fs1 = Fs;

load noise.mat;
data0 = audioData; fs0 = Fs;

%%%%% 1. Parámetros Espectrograma
T_spect = 0.02; 

%%%%% 2. Obtención de espectrogramas
figure;
spectrogram(data0(:,2), round(T_spect*fs0), [], [], fs0, 'yaxis');
title("Espectrograma de señal aleatoria por bypass LCDK");

figure
spectrogram(data1(:,2)', round(T_spect*fs1), [], [], fs1, 'yaxis');
title("Espectrograma de señal aleatoria por phaser LCDK");