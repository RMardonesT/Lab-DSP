clear all; close all; clc;

[data,fs] = audioread("aliasing_test_16_16.wav", "native");

N = 161;           %Largo del vector a procesar
x = data(1:N);     %Primeras N muestras del archvio de audio
w = blackman(N)    %Ventana blackman tamaño N tipo Double

w_int16 = int16(w); %casteo de w Double-to-int16


whos  %información variables 


%% Operación punto fijo  interpretación Q15

q = int16(15);

c_ri = (x.*w_int16)%/(2^q);

c = c_ri/(2^q);

% whos
% plot(x)
% hold on
plot(w_int16)
hold on
plot(c_ri)

%% procedimiento importando sin native

[data2,fs] = audioread("aliasing_test_16_16.wav");

x2 = data2(1:N);  %%Primeras N muestras del archvio de audio tipo Double
w2 = blackman(N);

c2 = x2.*w2;  %Enventamiento punto flotante


plot(x2)





