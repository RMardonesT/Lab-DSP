%%%%% Lab 5 DSP
close all; clear; clc
%%% I.3

% Se excitan los filtros diseñados anteriormente con tren de pulsos
% generado

%PARAMETROS
t = 1;
T = 80;

N  = 1000; % Número de puntos de respuesta en frecuencia
FS = 8000;   % Frecuencia de muestreo
P  = 15;  % Número de polos en modelo AR

%INICIO

%%% 1. Generación de señal de entrada.
x = exciteV(t*FS,T);

%%% 2. Diseño de filtros.
load vowels

% Diseño de filtros
a_vowel_a = lpc(vowel_a,P);
a_vowel_e = lpc(vowel_e,P);
a_vowel_i = lpc(vowel_i,P);
a_vowel_o = lpc(vowel_o,P);
a_vowel_u = lpc(vowel_u,P);

%%% 3. Generacion de archivos de audio (filtrado)
y_a = filter(1, a_vowel_a, x);
y_e = filter(1, a_vowel_e, x);
y_i = filter(1, a_vowel_i, x);
y_o = filter(1, a_vowel_o, x);
y_u = filter(1, a_vowel_u, x);

%%% 4. Guardado en archivo de audio
audiowrite("matlab_vowel_a.wav",y_a,FS);
audiowrite("matlab_vowel_e.wav",y_e,FS);
audiowrite("matlab_vowel_i.wav",y_i,FS);
audiowrite("matlab_vowel_o.wav",y_o,FS);
audiowrite("matlab_vowel_u.wav",y_u,FS);

%%% 5. Espectros en frecuencia
%Respuestas en frecuencia

A = fft(y_a, N);
E = fft(y_e, N);
I = fft(y_i, N);
O = fft(y_o, N);
U = fft(y_u, N);

f = (0:N/2-1)*FS*1/N;

% Graficos
figure
plot(f,mag2db(abs(A(1:N/2))));
title("Espectro en frecuencia de letra A sintetizada");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(E(1:N/2))));
title("Espectro en frecuencia de letra E sintetizada");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(I(1:N/2))));
title("Espectro en frecuencia de letra I sintetizada");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(O(1:N/2))));
title("Espectro en frecuencia de letra O sintetizada");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(U(1:N/2))));
title("Espectro en frecuencia de letra U sintetizada");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");