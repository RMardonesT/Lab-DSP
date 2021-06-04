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
xlabel("Frecuencia [Hz]");ylabel("Amplitud [-]");
title("Contenido en frecuencia de nspech.mat usando FFT de N puntos");

%%% Diseño y gráfico de Filtro en frecuencia

%Del grafico theta = 1.323 -> coinciden
%filtro -> H(w) =  1-2cos(1.323)*e^jw  + e^-2jw
%filtro -> H[z] = 1-0.49*z + z^-2

N = Nx + 3 - 1; %Valor de N para evitar aliasing temporal
f = (0:(N-1))*fs/N;

ejw = exp(1j*2*pi*(0:N-1)/N);
H   = 1-2*cos(1.323)*ejw  + ejw.^2;

figure
plot(f,abs(H));xlim([0 4000])
ylabel("Amplitud [-]"); xlabel("Frecuencia [Hz]");
title ("Respuesta en frecuencia de filtro H(z)");

%%% Espectro de filtrado en frecuencia
Y = fft(x , N).* H;

figure
plot(f,20*log10(abs(Y)));xlim([0 4000])
ylabel("Amplitud [-]"); xlabel("Frecuencia [Hz]");
title ("Espectro en frecuencia de señal nspeech.mat filtrada");

%%% Reconstrucción temporal
y = ifft(Y,"symmetric");

figure
plot((0:length(y)-1)*1/fs,y);
ylabel("Amplitud [-]"); xlabel("Tiempo [s]");
title ("Espectro en frecuencia de señal nspeech.mat filtrada");
%[nspeech_dtft, w_nspeech] = DTFT(nspeech,0);
%plot(w_nspeech,(abs(nspeech_dtft)/length(nspeech)))
%xlim([0,pi/2])








