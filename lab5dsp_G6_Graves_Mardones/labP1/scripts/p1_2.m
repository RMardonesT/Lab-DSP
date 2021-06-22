%%%%% Lab 5 DSP
close all; clear; clc
%%% I.2

% A partir de archivo vowels.mat se obtienen los parámetros del filtro AR
% con el comando lpc de MATLAB. Se grafican las magitudes de cada uno de
% los filtros.

%PARAMETROS
N  = 200; % Número de puntos de respuesta en frecuencia
FS = 8000;   % Frecuencia de muestreo
P  = 15;  % Número de polos en modelo AR

%INICIO
load vowels

% Diseño de filtros
a_vowel_a = lpc(vowel_a,P);
a_vowel_e = lpc(vowel_e,P);
a_vowel_i = lpc(vowel_i,P);
a_vowel_o = lpc(vowel_o,P);
a_vowel_u = lpc(vowel_u,P);

%Respuestas en frecuencia
A_f = freqz(1,a_vowel_a, N/2);
E_f = freqz(1,a_vowel_e, N/2);
I_f = freqz(1,a_vowel_i, N/2);
O_f = freqz(1,a_vowel_o, N/2);
U_f = freqz(1,a_vowel_u, N/2);

f = (0:N/2-1)*FS*1/N;

% Graficos
%figure
%plot(f,abs(A_f));
%hold on
%plot(f,abs(E_f));plot(f,abs(I_f));plot(f,abs(O_f));plot(f,abs(U_f));
%title("Respuestas en frecuencia modelos AR usando lpc para vocales");
%title("Respuesta en frecuencia modelo AR letra A");
%xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");
%legend("a","e","i","o","u")

figure
plot(f,abs(A_f));
title("Respuesta en frecuencia modelo AR letra A");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(E_f));
title("Respuesta en frecuencia modelo AR letra E");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(I_f));
title("Respuesta en frecuencia modelo AR letra I");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(O_f));
title("Respuesta en frecuencia modelo AR letra O");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(U_f));
title("Respuesta en frecuencia modelo AR letra U");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");