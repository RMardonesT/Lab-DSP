%%%%% Lab 5 DSP
close all; clear; clc
%%% I.4

load vowels

N  = 200; % Número de puntos de respuesta en frecuencia
FS = 8000;   % Frecuencia de muestreo
P  = 15;  % Número de polos en modelo AR

vocals_filt = zeros(5,16);
% Generación de filtros
% Diseño de filtros
a_vowel_a = mylpc(vowel_a,P);
a_vowel_e = mylpc(vowel_e,P);
a_vowel_i = mylpc(vowel_i,P);
a_vowel_o = mylpc(vowel_o,P);
a_vowel_u = mylpc(vowel_u,P);

%Respuestas en frecuencia
A_f = freqz(1,a_vowel_a, N/2);
E_f = freqz(1,a_vowel_e, N/2);
I_f = freqz(1,a_vowel_i, N/2);
O_f = freqz(1,a_vowel_o, N/2);
U_f = freqz(1,a_vowel_u, N/2);

f = (0:N/2-1)*FS*1/N;

% Graficos

figure
plot(f,abs(A_f));
title("Respuesta en frecuencia modelo AR letra A (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(E_f));
title("Respuesta en frecuencia modelo AR letra E (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(I_f));
title("Respuesta en frecuencia modelo AR letra I (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(O_f));
title("Respuesta en frecuencia modelo AR letra O (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");

figure
plot(f,abs(U_f));
title("Respuesta en frecuencia modelo AR letra U (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [-]");