%%%%% Parte III Lab 4 DSP
close all; clear; clc;
load("nspeech.mat");

x = nspeech; Nx = length(x); %Se agrega archivo al workspace

%%% Identificación de tono no deseado 

% Del gráfico: (f0 = 1685; 1685*2pi/8k = 1.322)
X = fft(x,Nx);
fx = (0:(Nx-1))*fs/Nx;

figure
plot(fx,20*log10(abs(X)));xlim([0,4000])
xlabel("Frecuencia [Hz]");ylabel("Magnitud [dB]");
title("Contenido en frecuencia de nspech.mat usando FFT de N puntos");

%%% Diseño y gráfico de Filtro en frecuencia

%Del grafico theta = 1.323 -> coinciden
%filtro -> H(w) =  1-2cos(1.323)*e^-jw  + e^-2jw
%filtro -> H[z] = 1-0.49*z^-1 + z^-2

N = Nx;% + 3 - 1; %Valor de N para evitar aliasing temporal
f = (0:(N-1))*fs/N;

ejw_n = exp(-1j*2*pi*(0:N-1)/N);
H     = 1-2*cos(1.323)*ejw_n  + ejw_n.^2;

figure
plot(f,abs(H));xlim([0 4000])
ylabel("Amplitud [-]"); xlabel("Frecuencia [Hz]");
title ("Respuesta en frecuencia de filtro H(z)");

%%% Espectro de filtrado en frecuencia
X = fft(x , N);
Y = X.* H;

figure
plot(f,20*log10(abs(Y)));xlim([0 4000])
ylabel("Magnitud [dB]"); xlabel("Frecuencia [Hz]");
title ("Espectro en frecuencia de señal nspeech.mat filtrada");

%%% Reconstrucción temporal
y = ifft(Y,"symmetric");

figure
subplot 211
plot((0:Nx-1)*1/fs,x);
ylabel("Amplitud [-]"); xlabel("Tiempo [s]");
title ("Señal nspeech.mat");
subplot 212
plot((0:length(y)-1)*1/fs,y);
ylabel("Amplitud [-]"); xlabel("Tiempo [s]");
title ("Señal nspeech.mat filtrada");

%%% Guardado de audios para comparación
audiowrite("nspeech_unfiltered.wav",x,fs);
audiowrite("nspeech_filtered.wav",y,fs);