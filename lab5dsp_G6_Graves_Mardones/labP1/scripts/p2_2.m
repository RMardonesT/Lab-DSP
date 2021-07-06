%%%%% LAB 5 DSP Parte 2
close all;clear; clc
load test_training_signals.mat

%%% Parte 2.2

%PARÁMETROS
UMBRAL_RMS0    = (0.0120794 + 0.00765744)/2;
UMBRAL_RMS1    = (0.0685488 + 0.0543576)/2;
UMBRAL_CRUCES0 = 1.5;
UMBRAL_CRUCES1 = 2.5;
UMBRAL_MIX0    = 0; 
UMBRAL_MIX1    = 0;

% Importación de señal de prueba
signal = training_signal;

%Número de muestras para ventana de 20 ms
L = 0.02*fs;

%Padding de la señal
N_signal = length(signal);
if (mod(N_signal,L)~= 0)
    signal = [signal ;zeros(L-mod(N_signal,L),1)];
end

N = length(signal)/L; %Número de ventanas

vec_rms    = zeros(1,N);
vus_rms    = zeros(1,N);
vus_cruces = zeros(1,N);
vus_mix    = zeros(1,N);

for i = 1:N
    subsignal = signal(1+(i-1)*L:i*L);
    
    %Obtencion de métricas
    sub_rms   = rms(subsignal); vec_rms(i) = sub_rms;
    sub_ceros = cruces_zero(subsignal,fs);
    %sub_mix   = 
    
    
    
    %Clasificación
    % 1. RMS
    if (sub_rms < UMBRAL_RMS0)     %S
        vus_rms(i) =  0;    
    elseif (sub_rms < UMBRAL_RMS1) %U
        vus_rms(i) = -1;
    else
        vus_rms(i) =  1;           %V 
    end
    
    %2. Cruces por cero
    if (sub_rms < UMBRAL_CRUCES0)     %S
        vus_cruces(i) =  0;    
    elseif (sub_rms < UMBRAL_CRUCES1) %U
        vus_cruces(i) = -1;
    else
        vus_cruces(i) =  1;        %V 
    end
    
    %3. Mezcla.    
end
%A este punto comparación manual de metodos clasificacion vus


figure
subplot 311 %test_signal
plot((0:length(signal)-1)/fs, signal);
title("Representación temporal señal test\_signal")
xlabel("Tiempo [s]");ylabel("Amplitud [-]")

subplot 312 %test_signal
stairs((0:N-1)*.02, vus_rms);
title("Clasificación VUS usando rms en ventanas de 20 ms para test\_signal")
xlabel("Tiempo [s]");ylabel("Tipo [-]")

subplot 313 %test_signal
stairs((0:N-1)*.02, vec_rms);
title("Valor RMS en ventanas de 20 ms para test\_signal")
xlabel("Tiempo [s]");ylabel("Amplitud [-]")






