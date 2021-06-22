%%%%% Lab 5 DSP
close all; clear; clc
%%% I.3

% Se excitan los filtros diseñados anteriormente con tren de pulsos
% generado

%PARAMETROS
t = 1;
T = 80;

N  = 200; % Número de puntos de respuesta en frecuencia
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
audiowrite("A_lpc.wav",y_a,FS);
audiowrite("E_lpc.wav",y_e,FS);
audiowrite("I_lpc.wav",y_i,FS);
audiowrite("O_lpc.wav",y_o,FS);
audiowrite("U_lpc.wav",y_u,FS);