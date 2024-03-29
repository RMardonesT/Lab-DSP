%%%%% Parte II Lab 4 DSP

close all; clear; clc

Fs = 2000; Ts = 1/Fs; t = 0:Ts:0.1-Ts; N = length(t);

% ruido, actualizar a gaussiano
n = sqrt(1/0.0909)*wgn(1,length(t) ,2,"linear"); %wgn(1,length(t),)
var(n)

% señal limpia
s = .5*cos(2*pi*100*t) + 1.5*sin(2*pi*500*t);

% señal con ruido
sn = s + n;

%%% p21: Gráfico en el tiempo 
figure
plot(t,sn);
xlabel("tiempo [s]");ylabel("Amplitud [-]");
title("2 tonos puros con ruido blanco gaussiano de variaza 2 y media 0")

%%% p22: FFT y gráficos de amplitud en frecuencia
S = fft(s,N);
SN = fft(sn,N);
f  = (0:(N-1))*Fs/N;

figure
subplot 211
stem(f, abs(S));xlim([0 1000]);
xlabel("Frecuencia [Hz]");ylabel("Amplitud [-]");
title("Contenido en frecuencia de señal limpia");
subplot 212
stem(f, abs(SN));xlim([0 1000]);
xlabel("Frecuencia [Hz]");ylabel("Amplitud [-]");
title("Contenido en frecuencia de señal ruidosa");

%%%p23: Gráfico en dB para contenido en frecuencia 
%100 ms
S_dB = 20*log10(abs(S));
SN_dB = 20*log10(abs(SN));

figure
subplot 211
plot(f, S_dB - max(S_dB));xlim([0 1000]);
xlabel("Frecuencia [Hz]");ylabel("Amplitud [dB]");
title("Contenido en frecuencia de señal limpia en dB (0.1s)");
subplot 212
plot(f, SN_dB - max(SN_dB));xlim([0 1000]);
xlabel("Frecuencia [Hz]");ylabel("Amplitud [dB]");
title("Contenido en frecuencia de señal ruidosa en dB (0.1s)");

%1s
Fs = 2000; Ts = 1/Fs; t = 0:Ts:1-Ts; N = length(t);

n = sqrt(1/0.0909)*wgn(1,length(t) ,2,"linear"); var(n)     % rudio wgn(1,length(t),)
s = .5*cos(2*pi*100*t) + 1.5*sin(2*pi*500*t); % señal limpia
sn = s + n;                                   % señal con ruido

f  = (0:(N-1))*Fs/N;
S = fft(s);
SN = fft(sn);
S_dB = 20*log10(abs(S));
SN_dB = 20*log10(abs(SN));

figure
subplot 211
plot(f, S_dB - max(S_dB));xlim([0 1000]);
xlabel("Frecuencia [Hz]");ylabel("Amplitud [dB]");
title("Contenido en frecuencia de señal limpia en dB (1s)");
subplot 212
plot(f, SN_dB - max(SN_dB));xlim([0 1000]);
xlabel("Frecuencia [Hz]");ylabel("Amplitud [dB]");
title("Contenido en frecuencia de señal ruidosa en dB (1s)");