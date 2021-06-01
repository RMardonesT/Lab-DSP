clear all; clc;
load("nspeech.mat");


x = nspeech;

N = length(x)
X = fft(x,N);

f = (0:(N-1))*fs/N;

plot(f,abs(X))
xlim([0,4000])

%del gráfico f0 = 1685 -> 1685*2pi/8k = 1.322

[nspeech_dtft, w_nspeech] = DTFT(nspeech,0);
plot(w_nspeech,(abs(nspeech_dtft)/length(nspeech)))
xlim([0,pi/2])



%Del grafico theta = 1.323 -> coinciden


%filtro -> H(w) =  1-2cos(1.323)*e^jw  + e^-2jw

%filtro -> H[z] = 1-0.49*z + z^-2




