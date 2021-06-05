clear all;clc;
load('pcm.mat')

[pcm_dtft, w_pcm] = DTFT(pcm,0);

magPcm = abs(pcm_dtft);

plot(w_pcm,magPcm)
title("DTFT de la señal de audio pcm.mat","FontSize",18)
ylim([-20,250])
xlabel("Frecuencia normalizada rad/s","FontSize",16)
ylabel("Magnitud [-]","FontSize",16)
grid on


%%
 % Filtrado iir

% Creando estado del filtro
filtered_pcm = zeros(1,length(pcm));
yBuff = [0 0];
r = 0.99;
theta = 2.471;

aCoeff = [-2*r*cos(theta) r*r];

for i = 1:length(pcm)
    yBuff = IIR_filter(yBuff, aCoeff, pcm(i));
    filtered_pcm(i) = (1-r)*yBuff(1);
end

%% 
[pcm_fil, w_pcm_fil] = DTFT(filtered_pcm,0);

subplot(2,2,1)
plot(w_pcm,magPcm)
title("DTFT de la señal de audio pcm.mat","FontSize",22)
ylim([-20,250])
xlabel("Frecuencia normalizada rad/s","FontSize",20)
ylabel("Magnitud [-]","FontSize",20)
grid on

subplot(2,2,3)
plot(w_pcm_fil, abs(pcm_fil))
title("DTFT de la señal de audio pcm.mat filtrada ","FontSize",22)
ylim([-20,250])
xlabel("Frecuencia normalizada rad/s","FontSize",20)
ylabel("Magnitud [-]","FontSize",20)
grid on



subplot(2,2,2)
plot(w_pcm,20*log10(magPcm))
title("DTFT en dB de la señal de audio pcm.mat","FontSize",22)
ylim([-20,250])
xlabel("Frecuencia normalizada rad/s","FontSize",20)
ylabel("Magnitud [-]","FontSize",20)
grid on

subplot(2,2,4)
plot(w_pcm_fil, 20*log10(abs(pcm_fil)))
title("DTFT en dB de la señal de audio pcm.mat filtrada","FontSize",22)
ylim([-20,250])
xlabel("Frecuencia normalizada rad/s","FontSize",20)
ylabel("Magnitud [-]","FontSize",20)
grid on



