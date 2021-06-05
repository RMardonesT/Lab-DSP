%%%%% Parte III Lab 3 DSP
close all; clear; clc
%%% 1. Diseño de filtros IIR usando ellip

%ordenes
n1a = 2; n1b = 2; n1c = 4/2; n1d = 4/2;
%frecuencias de corte normalizadas (pasa bajos y pasa altos)
Fs = 16000; fc1_a1_Hz = 2000; fc1_a1 = fc1_a1_Hz/Fs;   %filtro a (LP)
fc1_b1_Hz = 4000; fc1_b1 = fc1_b1_Hz/Fs;               %filtro b (HP)
%frecuencias normalizadas (pasa banda y elimina banda)
f1_c1_Hz = 2000; f1_c1 = f1_c1_Hz/Fs;                  %filtro c (BP)
f1_c2_Hz = 4000; f1_c2 = f1_c2_Hz/Fs;
f1_d1_Hz = 2000; f1_d1 = f1_d1_Hz/Fs;                  %filtro d (SB)
f1_d2_Hz = 4000; f1_d2 = f1_d2_Hz/Fs;
%Suposiciones de ripple y banda de rechazo
Rp = 5; Rs = 20; %Ripple banda de paso y atenuación banda de rechazo  
%Diseño de Filtros 
[b1_a, a1_a] = ellip(n1a, Rp, Rs, 2*fc1_a1, "low");
[b1_b, a1_b] = ellip(n1b, Rp, Rs, 2*fc1_b1, "high");
[b1_c, a1_c] = ellip(n1c, Rp, Rs, 2*[f1_c1 f1_c2], "bandpass");
[b1_d, a1_d] = ellip(n1d, Rp, Rs, 2*[f1_d1 f1_d2], "stop");

%Visualización en frecuencia [b,a] = ellip(n,Rp,Rs,Wp,ftype)
figure; freqz(b1_a, a1_a);
title("Respuesta en frecuencia filtro pasa bajos elíptico")
figure; freqz(b1_b, a1_b);
title("Respuesta en frecuencia filtro pasa altos elíptico")
figure; freqz(b1_c, a1_c);
title("Respuesta en frecuencia filtro pasa banda elíptico")
figure; freqz(b1_d, a1_d);
title("Respuesta en frecuencia filtro elimina banda elíptico")

%%% 2. Diseño de filtros chebyshev tipo I y II

%orden
n2 = 4/2;
%frecuencias de corte
f2_1_Hz = 2000; f2_1 = f2_1_Hz/Fs;
f2_2_Hz = 4000; f2_2 = f2_2_Hz/Fs;
%Restricciones de Ripple
Rp = 2; Rs = 20;
%Diseño de Filtros [b,a] = cheby1(n,Rp,Wp,ftype)
[b2_a, a2_a] = cheby1(n2, Rp, 2*[f2_1 f2_2], "bandpass");
[b2_b, a2_b] = cheby2(n2, Rs, 2*[f2_1 f2_2], "bandpass");

%Visualización en frecuencia [b,a] = ellip(n,Rp,Rs,Wp,ftype)
figure; freqz(b2_a, a2_a); [h2_a,w2_a] = freqz(b2_a, a2_a);
sprintf("Filtro chebyshev tipo I:")
sprintf("A frecuencia normalizada %f pi rad/muestta hay una ganancia de %f dB",w2_a(42) ,20*log10(abs(h2_a(42))))
sprintf("A frecuencia normalizada %f pi rad/muestta hay una ganancia de %f dB",w2_a(82) ,20*log10(abs(h2_a(82))))
title("Respuesta en frecuencia filtro chebyshev tipo I pasabanda")
figure; freqz(b2_b, a2_b); [h2_b,w2_b] = freqz(b2_b, a2_b); abs(h2_b(42))
title("Respuesta en frecuencia filtro chebyshev tipo II pasabanda")
sprintf("Filtro chebyshev tipo II:")
sprintf("A frecuencia normalizada %f pi rad/muestta hay una ganancia de %f dB",w2_b(42) ,20*log10(abs(h2_b(42))))
sprintf("A frecuencia normalizada %f pi rad/muestta hay una ganancia de %f dB",w2_b(82) ,20*log10(abs(h2_b(82))))

%%% 3. Diseño de filtros butterworth

%orden
n3 = 4/2;
%frecuencias de corte
f3_1_Hz = 800 ; f3_1 = f3_1_Hz/Fs;
f3_2_Hz = 1600; f3_2 = f3_2_Hz/Fs;
%Diseño de Filtros [b,a] = cheby1(n,Rp,Wp,ftype)
[b3, a3] = butter(n3, 2*[f3_1 f3_2], "bandpass");
%Visualización en frecuencia [b,a] = ellip(n,Rp,Rs,Wp,ftype)
figure; freqz(b3, a3);
title("Respuesta en frecuencia de filtro butterworth pasabanda orden 4");

%Análisis de polos y ceros butterworth 
n = [4 6 8 10 12 14];
figure
for i = 1:6
    [z,p,~] = butter(n(i)/2, 2*[f3_1 f3_2], "bandpass");
    subplot(3,2,i); zplane(z,p);
    title({"Diagrama de polos y ceros para filtro ", strcat("butterworth pasabandas de orden ", int2str(n(i)))})
end