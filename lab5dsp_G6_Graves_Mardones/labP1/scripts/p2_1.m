%%%%% LAB 5 DSP Parte 3
close all;clear; clc
load test_training_signals.mat

%%% Parte 3.1
x = training_signal;
%soundsc(x, fs);
N = length(x);
t = (0:N-1)/fs;

figure
plot(t,x)
xlabel("tiempo [s]"); ylabel("Amplitud")
title("Señal training\_signal vs tiempo")

[x,y] = ginput(20);

