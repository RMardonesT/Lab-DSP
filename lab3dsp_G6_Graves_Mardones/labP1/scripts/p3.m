%%%%% Parte III Lab 3 DSP
close all; clear; clc
%%% 1. Diseño de filtros FIR usando fir1

%orden
n1 = 70;
%frecuencia de corte normalizada
Fs = 16000; fc_Hz = 3000; fc = fc_Hz/Fs;
%ventanas
win11 = ones(n1+1,1);win12 = blackman(n1+1);
%diseño
b11 = fir1(n1,fc,win11); b12 = fir1(n1,fc,win12);
%Visualización
%[f11,h11] = freqz(b11,a1); [f12,h12] = freqz(b12,a1);
figure
freqz(b11,1)
title("Respuesta en frecuencia filtro diseñado con ventana rectangular usando fir1")
figure
freqz(b12,1)
title("Respuesta en frecuencia filtro diseñado con ventana blackman usando fir1")

%%% 2. Diseño de filtros FIR usando fir2

%orden 
n21 = 70; n22 = 150;
%Objetivo en frecuencia
f_obj = [0 .1 .15 .35 .4 .65 .75 1];
h_obj = [1  1   0   0 .5  .5   0 0];
%diseño
b21 = fir2(n21,f_obj, h_obj); b22 = fir2(n22,f_obj, h_obj);
%Respuesta en frecuencia
[h21,w21] = freqz(b21,1); [h22,w22] = freqz(b22,1);

figure
plot(f_obj,h_obj);hold on
plot(w21/(pi),abs(h21)); plot(w22/(pi),abs(h22));
title("Comparación respuestas en frecuencia obtenidas con fir2","FontSize",18)
xlabel("Frecuencia normalizada [\times\pi rad/muestra]","FontSize",16)
ylabel("Magnitud [-]","FontSize",16)
legend("Respuesta en frecuencia objetivo", "fir2 orden 70", "fir2 orden 150")

figure
plot(w21/(pi),20*log10(abs(h21))); hold on;
plot(w22/(pi),20*log10(abs(h22)));
title("Comparación respuestas en frecuencia obtenidas con fir2","FontSize",18)
xlabel("Frecuencia normalizada [\times\pi rad/muestra]","FontSize",16)
ylabel("Magnitud [dB]","FontSize",16)
legend("fir2 orden 70", "fir2 orden 150")