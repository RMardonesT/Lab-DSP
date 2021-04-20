%% rp6
close all; clear; clc
%% a

[aliasing,Fs] = audioread('aliasing_test_16_16.wav','native');
% Se obtiene Fs = 16kHz y una señal int16 de 51203 muestras (col)

%Enventanamiento con Punto Fijo 
N = 161;
x = aliasing(1:N); %Primeras N = 161 muestras (col)

w = blackman(N);    %Ventana blackman de N muestras. Tipo double

q = 15; w_int16 = int16(w*2^q); %Casteo de ventana

y_ri = int32(x).*int32(w_int16)/int32((2^q)); y_ri = int16(y_ri);
y = y_ri/(2^q); %Enventanamiento en punto fijo

[aliasing_d,Fs_d] = audioread('aliasing_test_16_16.wav');
x_d = aliasing_d(1:N); y_d = x_d.*w;% Enventanamiento punto flotante

disp("Parte a:\n");
whos %w ocupa 1288 double y w_int 322 int16

figure
plot(x);hold on
plot(w_int16);
plot(y_ri);
title("Punto Fijo")

figure
plot(double(x)*2^-double(q));hold on
plot(double(w_int16)*2^-double(q));
plot(double(y_ri)*2^-double(q));
title("Interpretación punto fijo usando Q15")

figure
plot(x_d);hold on
plot(w);
plot(y_d);
title("Punto flotante")

