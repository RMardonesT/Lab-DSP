%%%%% Parte VI Lab 4 DSP
close all; clear; clc
size1 = 15;
tsize = 12;
%%% 1. Testeo de DFTdc

% Señales de prueba
sa = [1 zeros(1,7)];
sb = ones(1,8);
sc = exp(-1j*2*pi*(0:7)/8);

% Transformaciones con DFTdc
Sa = DFTdc(sa);
Sb = DFTdc(sb);
Sc = DFTdc(sc);
% Transformaciones fft
Sa_fft = fft(sa);
Sb_fft = fft(sb);
Sc_fft = fft(sc);

%Medición de tiempos
f1 = @() DFTdc(sc); t1 = timeit(f1);
f2 = @() fft(sc)  ; t2 = timeit(f2);

subplot 231 
stem(0:7,abs(Sa));xlim([0 7])
xlabel("Bins de frecuencia [-]","FontSize",size1);
ylabel("Magnitud [-]","FontSize",size1)
title("Magnitud de DFT de x(n) = \delta(n) usando DFTdc","FontSize",tsize)
subplot 232 
stem(0:7,abs(Sb));xlim([0 7])
xlabel("Bins de frecuencia [-]","FontSize",size1);
xlabel("Bins de frecuencia [-]","FontSize",size1);
ylabel("Magnitud [-]","FontSize",size1)
title("Magnitud de DFT de x(n) = 1 usando DFTdc","FontSize",tsize)
subplot 233 
stem(0:7,abs(Sc));xlim([0 7])
xlabel("Bins de frecuencia [-]","FontSize",size1);
ylabel("Magnitud [-]","FontSize",size1)
title("Magnitud de DFT de x(n) = exp(-j2\pi n/8) usando DFTdc","FontSize",tsize)

subplot 234 
stem(0:7,abs(Sa_fft));xlim([0 7])
xlabel("Bins de frecuencia [-]","FontSize",size1);
ylabel("Magnitud [-]","FontSize",size1)
title("Magnitud de DFT de x(n) = \delta(n) usando fft","FontSize",tsize)
subplot 235 
stem(0:7,abs(Sb_fft));xlim([0 7])
xlabel("Bins de frecuencia [-]","FontSize",size1);
ylabel("Magnitud [-]","FontSize",size1)
title("Magnitud de DFT de x(n) = 1 usando fft","FontSize",tsize)
subplot 236 
stem(0:7,abs(Sc_fft));xlim([0 7])
xlabel("Bins de frecuencia [-]","FontSize",size1);
ylabel("Magnitud [-]","FontSize",size1)
title("Magnitud de DFT de x(n) = exp(-j2\pi n/8) usando fft","FontSize",tsize)