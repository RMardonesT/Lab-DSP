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



 % Filtrado iir

% Creando estado del filtro
filtered_pcm = zeros(1,length(pcm));
yBuff = [0 0];
r = 0.99;
theta = 2.471;

aCoeff = [-2*r*cos(theta) r*r];

for i = 1:length(pcm)
    yBuff = IIR_filter(yBuff, aCoeff, pcm(i));
    filtered_pcm(i) = yBuff(1);
end

