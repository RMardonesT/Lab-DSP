clc; clear all
Fs = 16000;
f0 = 440;
BW = 50;

theta = 2*pi*f0/Fs;
bw = 2*pi*BW/Fs;

format long

[a,b,d] = notch(bw,theta)