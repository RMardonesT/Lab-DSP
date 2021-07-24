%%%%% Lab 5 DSP Parte V
close all; clear; clc

%%% Parte 1. Comparación filtro y filtro inverso
load vowels.mat

% Obtención de filtros
a = lpc(vowel_a,15);
b_inv = a;

% Obtenciión de respuestas en frecuencia
[h,w] = freqz(1,a); [h_inv,w_inv] = freqz(b_inv,1);

% Gráficos
figure
plot(w,mag2db(abs(h)))
hold on
plot(w_inv,mag2db(abs(h_inv)))
xlim([0 pi])
xlabel("Frecuencia Normalizada [rad/muestra]")
ylabel("Amplitud [dB]")
title("Comparación respuestas en frecuecnia filtro y filtro inverso")
legend("Filtro AR", "Filtro inverso")

%%% Parte 2. Gráfico de residuo
e = filter(b_inv,1,vowel_a);

%Grafico
t = (0:(length(vowel_a)-1))/fs;
xmin = 1;
xmax = 1.1;

figure
subplot 211
plot(t,vowel_a)
xlabel("Tiempo [s]")
ylabel("Amplitud")
title("Señal vowel\_a")
xlim([xmin xmax])

subplot 212
plot(t,e)
xlabel("Tiempo [s]")
ylabel("Amplitud")
title("Señal de entrada obtenida a partir de filtro inverso")
xlim([xmin xmax])

%%% Parte 3. Espectro del residuo
[he,we] = positiveSpectrum(e);
[ha,wa] = positiveSpectrum(vowel_a);

figure
subplot 211
plot(we,mag2db(abs(he)))
xlabel("Frecuencia normalizada [rad/muestra]")
ylabel("Amplitud [dB]")
title("Visualzación en frecuencia de residuo")
xlim([0 pi])

subplot 212
plot(wa, mag2db(abs(ha)))
xlabel("Frecuencia normalizada [rad/muestra]")
ylabel("Amplitud [dB]")
title("Visualzación en frecuencia de señal vowel\_a")
xlim([0 pi])

%%% Parte 4. Autocorrelación del residuo y pitch

% Obtención de autocorrelaciones
re = xcorr(e);
ra = xcorr(vowel_a);

%Gráficos
k = (1:length(ra)) - length(vowel_a);

figure
subplot 211
plot(k,re)
xlim([-1000 1000])
xlabel("Desfase de muestras [-]")
ylabel("Amplitud")
title("Autocorrelación de residuo")

subplot 212
plot(k,ra)
xlim([-1000 1000])
xlabel("Desfase de muestras [-]")
ylabel("Amplitud")
title("Autocorrelación de vowel\_a")