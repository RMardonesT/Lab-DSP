clear all;clc;

titleSize = 22;  %,"FontSize",titleSize)
labelSize = 18   %,"FontSize",labelSize)
% Definiciones generales
fs = 1000;
N = 100; % Largo de la ventana
n = 0:N; % 100 ms
wc = 2*pi/3; % Frecuecia de corte del filtro
t = 0:(1/fs):(N/fs);

h_ideal = (wc/pi)*sinc((wc/pi)*(n - (N-1)/2));

% Ventanas
h_rect = rectwin(N+1);
[H_rect, w_rect] = freqz(h_rect);

h_hamming = hamming(N + 1);
[H_hamming, w_hamming] = freqz(h_hamming);

h_hanning = hann(N + 1);
[H_hanning, w_hanning] = freqz(h_hanning);

h_blackman = blackman(N + 1);
[H_blackman, w_blackman] = freqz(h_blackman);

h_bartlett = bartlett(N + 1);
[H_bartlett, w_bartlett] = freqz(h_bartlett);

%% Graficos temporales ventanas
close all

subplot(5,1,1)
plot(t,h_rect)
title('Ventana Rectangular',"FontSize",titleSize) 
xlabel('Muestras ',"FontSize",labelSize)
ylabel('Amplitud [-]',"FontSize",labelSize)

subplot(5,1,2)
plot(t,h_hamming)
title('Ventana Hamming',"FontSize",titleSize)
xlabel('Muestras ',"FontSize",labelSize)
ylabel('Amplitud [-]',"FontSize",labelSize)

subplot(5,1,3)
plot(t,h_hanning)
title('Ventana Hanning',"FontSize",titleSize)
xlabel('Muestras ',"FontSize",labelSize)
ylabel('Amplitud [-]',"FontSize",labelSize)

subplot(5,1,4)
plot(t,h_blackman)
title('Ventana Blackman',"FontSize",titleSize)
xlabel('Muestras ',"FontSize",labelSize)
ylabel('Amplitud [-]',"FontSize",labelSize)

subplot(5,1,5)
plot(t,h_bartlett)
title('Ventana Bartlett',"FontSize",titleSize)
xlabel('Muestras ',"FontSize",labelSize)
ylabel('Amplitud [-]',"FontSize",labelSize)

%% Magnitud en db


subplot(5,1,1)
plot(w_rect, 20*log10(abs(H_rect)))
title('Magnitud de H_{rect}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 pi])


subplot(5,1,2)
plot(w_hamming, 20*log10(abs(H_hamming)))
title('Magnitud de H_{hamming}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 pi])


subplot(5,1,3)
plot(w_hanning, 20*log10(abs(H_hanning)))
title('Magnitud de H_{hanning}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 pi])



subplot(5,1,4)
plot(w_blackman, 20*log10(abs(H_blackman)))
title('Magnitud de H_{blackman}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 pi])


subplot(5,1,5)
plot(w_bartlett, 20*log10(abs(H_bartlett)))
title('Magnitud de H_{bartlett}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlabel("Frecuencia rad/s","FontSize",labelSize)
xlim([0 pi])


%% Magnitud en db zoom


subplot(5,2,1)
plot(w_rect, 20*log10(abs(H_rect)))
title('Magnitud de H_{rect}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on


subplot(5,2,3)
plot(w_hamming, 20*log10(abs(H_hamming)))
title('Magnitud de H_{hamming}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on


subplot(5,2,5)
plot(w_hanning, 20*log10(abs(H_hanning)))
title('Magnitud de H_{hanning}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on



subplot(5,2,7)
plot(w_blackman, 20*log10(abs(H_blackman)))
title('Magnitud de H_{blackman}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on


subplot(5,2,9)
plot(w_bartlett, 20*log10(abs(H_bartlett)))
title('Magnitud de H_{bartlett}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlabel("Frecuencia rad/s","FontSize",labelSize)
xlim([0 0.3])

grid on

%% Fase


subplot(5,2,2)
plot(w_rect, unwrap(phase(H_rect)))
title('Fase de H_{rect}(\omega)',"FontSize",titleSize)
ylabel('Fase [rads]',"FontSize",labelSize)
xlim([0 pi])
grid on

subplot(5,2,4)
plot(w_hamming, unwrap(phase(H_hamming)))
title('Fase de H_{hamming}(\omega)',"FontSize",titleSize)
ylabel('Fase [rads]',"FontSize",labelSize)
xlim([0 pi])
grid on


subplot(5,2,6)
plot(w_hanning, unwrap(phase(H_hanning)))
ylabel('Fase [rads]',"FontSize",labelSize)
title('Fase de H_{hanning}(\omega)',"FontSize",titleSize)
ylabel('Fase [rads]',"FontSize",labelSize)
xlim([0 pi])
grid on

subplot(5,2,8)
plot(w_blackman, unwrap(phase(H_blackman)))
title('Fase de H_{blackman}(\omega)',"FontSize",titleSize)
ylabel('Fase [rads]',"FontSize",labelSize)
xlim([0 pi])
grid on


subplot(5,2,10)
plot(w_bartlett, unwrap(phase(H_bartlett),pi))
title('Fase de H_{bartlett}(\omega)',"FontSize",titleSize)
xlabel("Frecuencia rad/s","FontSize",labelSize)
xlim([0 pi])
grid on

%% Magnitud en db zoom


subplot(5,1,1)
plot(w_rect, 20*log10(abs(H_rect)))
title('Magnitud de H_{rect}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on


subplot(5,1,2)
plot(w_hamming, 20*log10(abs(H_hamming)))
title('Magnitud de H_{hamming}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on


subplot(5,1,3)
plot(w_hanning, 20*log10(abs(H_hanning)))
title('Magnitud de H_{hanning}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on



subplot(5,1,4)
plot(w_blackman, 20*log10(abs(H_blackman)))
title('Magnitud de H_{blackman}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlim([0 0.3])
grid on


subplot(5,1,5)
plot(w_bartlett, 20*log10(abs(H_bartlett)))
title('Magnitud de H_{bartlett}(\omega)',"FontSize",titleSize)
ylabel('|H(\omega)| [dB]',"FontSize",labelSize)
xlabel("Frecuencia rad/s","FontSize",labelSize)
xlim([0 0.3])

grid on



