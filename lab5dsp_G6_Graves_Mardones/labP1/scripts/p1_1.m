clear all; clc;

%% 1.1

fs = 8000;
t =1;
f = 100;
T = fs/f;
y = exciteV(t*fs,T);
<<<<<<< Updated upstream

Y =   fft(y);
Ymod = abs(Y);
Ydb = 20*log10( 0.000000001 + Ymod(1:fs/2)); %%se incrementan los valores en una cantidad despreciable para evitar el log10(0)

figure
plot([0:fs/2-1],  Ydb(1:fs/2))

soundsc(y,fs)

=======
Y =   fft(y);
Ymod = abs(Y);
Ydb = 20*log10( 0.000000001 + Ymod(1:fs/2));  
plot([0:fs/2-1],  Ydb(1:fs/2));
xlabel("Frecuencia sps");ylabel("Magnitud")
title("Espectro en frecuencia del tren de impulsos")
>>>>>>> Stashed changes


