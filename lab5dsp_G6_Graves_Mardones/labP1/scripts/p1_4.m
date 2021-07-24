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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3. Generacion de archivos de audio (filtrado)

%PARAMETROS
t = 1;
T = 80;

N  = 1000; % Número de puntos de respuesta en frecuencia
FS = 8000;   % Frecuencia de muestreo
P  = 15;  % Número de polos en modelo AR

%INICIO

%%% 1. Generación de señal de entrada.
x = exciteV(t*FS,T);
y_a = filter(1, a_vowel_a, x);
y_e = filter(1, a_vowel_e, x);
y_i = filter(1, a_vowel_i, x);
y_o = filter(1, a_vowel_o, x);
y_u = filter(1, a_vowel_u, x);

%%% 4. Guardado en archivo de audio
audiowrite("mylpc_vowel_a.wav",y_a,FS);
audiowrite("mylpc_vowel_e.wav",y_e,FS);
audiowrite("mylpc_vowel_i.wav",y_i,FS);
audiowrite("mylpc_vowel_o.wav",y_o,FS);
audiowrite("mylpc_vowel_u.wav",y_u,FS);

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
title("Espectro en frecuencia de letra A sintetizada (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(E(1:N/2))));
title("Espectro en frecuencia de letra E sintetizada (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(I(1:N/2))));
title("Espectro en frecuencia de letra I sintetizada (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(O(1:N/2))));
title("Espectro en frecuencia de letra O sintetizada (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");

figure
plot(f,mag2db(abs(U(1:N/2))));
title("Espectro en frecuencia de letra U sintetizada (mylpc)");
xlabel("frecuencia [Hz]"); ylabel("Amplitud [dB]");