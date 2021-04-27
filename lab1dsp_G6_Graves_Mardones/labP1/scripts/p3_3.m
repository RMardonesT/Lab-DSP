%% Generación de Señales
close all; clear; clc;

%3
%Parte 1, señal cuadrada de fase 0;
fs = 44000;
n = 0:(fs*1-1); %Muestras para durar 1 segundo

Vpp = pi/4; f = 440; %Parámetros señal cuadrada (Valor peak-peak y frecuencia)

ss = zeros(1,fs*1);

figure(1)
for k = 1:6
    ss = ss + b(k,Vpp)*sin(2*pi*(2*k-1)*(f/fs)*n);
    if mod(k,2) == 0
        plot(n/fs,ss);
        hold on
    end
end
title("Aproximación de señal cuadrada")
ylabel("Amplitud");xlabel("tiempo (s)");
legend("{1,3}","{1,3,5,7}", "{1,3,5,7,9,11}")
xlim([0 1/f*3]) %3 periodos

% Parte 2, señal cuadrada de fase aleatoria;
ss_rand = zeros(1,fs*1);

figure(2)
for k = 1:6
    phi = 2*pi*rand(6,1);
    ss_rand = ss_rand + b(k,Vpp)*sin(2*pi*(2*k-1)*(f/fs)*n + phi(k));
end

sound(.1*ss_rand,fs);  

% Gráficos
subplot 211
plot(n/fs,ss);
title("Aproximación de señal cuadrada")
ylabel("Amplitud");xlabel("tiempo (s)");
xlim([0 1/f*3]) %3 periodos

subplot 212
plot(n/fs,ss_rand)
title({"Señal con formada con armónicos,","de fase aleatoria de señal cuadrada"})
ylabel("Amplitud");xlabel("tiempo (s)");
xlim([0 1/f*3]) %3 periodos

% Audio
%sound(.1*ss,fs); %Se ocupo menos volumen por uso de audífonos
%sound(.1*ss,fs);  %Se ocupo menos volumen por uso de audífonos


%FUNCTIONS
% n-ésimo armónico impar
function out = b(k,A) 
    out = 2*A/(pi*(2*k-1));
end