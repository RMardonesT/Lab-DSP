clear all; close all;
%% Filtro FIR

load('nspeech.mat')


%% DTFT
[nspeech_dtft, w_nspeech] = DTFT(nspeech,0);

magNspeech = abs(nspeech_dtft);

figure(1)

plot(w_nspeech,magNspeech)
title("DTFT de la señal de audio nspeech.m","FontSize",18)
ylim([-20,1000])
xlabel("Frecuencia normalizada rad/s","FontSize",16)
ylabel("Magnitud [-]","FontSize",16)
grid on

%% Filtrado de la señal

theta = 1.323; % del grafico

y_conv = FIR_filter(nspeech,theta);  

[Y, w] = DTFT(y_conv,0)






figure(2)
subplot(2,1,1)
plot(w_nspeech,magNspeech)
title("DTFT de la señal de audio nspeech.m","FontSize",18)
ylim([-20,80])
xlabel("Frecuencia normalizada rad/s","FontSize",16)
ylabel("Magnitud [-]","FontSize",16)
grid on

subplot(2,1,2)
plot(w,abs(Y))
title("DTFT de la señal de audio nspeech.m","FontSize",18)
ylim([-20,80])
xlabel("Frecuencia normalizada rad/s","FontSize",16)
ylabel("Magnitud [-]","FontSize",16)
grid on










