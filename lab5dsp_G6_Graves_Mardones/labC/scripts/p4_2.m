%%%%% Lab 5 DSP Parte IV
close all; clear; clc

%%% Parte 2
load vowels.mat

% Diseño de filtros y respuesta en frecuencia
a_15 = lpc(vowel_a, 15); a_2 = lpc(vowel_a, 2);
[h15, w15] = freqz(1,a_15); [h2, w2] = freqz(1,a_2);

%Obtención de contenido en frecuencia de vowel_A
[ha,wa] = positiveSpectrum(vowel_a);

%Gráficos
figure
plot(wa,mag2db(abs(ha)))
hold on 
plot(w15, mag2db(abs(h15)))
plot(w2, mag2db(abs(h2)))
xlabel("Frecuencia normalizada [rad/muestra]")
ylabel("Amplitud [dB]")
legend("Espectro señal vowel\_a","Respuesta en frecuencia P = 15", "Respuesta en frecuencia P = 2")
title("Visualzación en frecuencia de señal y filtros AR óptimos")





