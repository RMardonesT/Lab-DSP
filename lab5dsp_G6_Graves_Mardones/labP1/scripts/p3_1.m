%%%%% LAB 5 DSP Parte 3
close all;clear; clc
load test_training_signals.mat

%%% Parte 2.2

%PARÁMETROS
UMBRAL_RMS0 = (0.0120794 + 0.00765744)/2;
UMBRAL_RMS1 = (0.0685488 + 0.0543576)/2;

P  = 15;  % Número de polos en modelo AR

% Importación de señal de prueba
signal = test_signal;

%Número de muestras para ventana de 20 ms
L = 0.02*fs;

%Padding de la señal
N_signal = length(signal);
if (mod(N_signal,L)~= 0)
    signal = [signal ;zeros(L-mod(N_signal,L),1)];
end

N = length(signal)/L; %Número de ventanas

vec_vus = zeros(1,N);
vec_rms = zeros(1,N);
A       = zeros(N,P+1);

%1. Proceso de compresión
for i = 1:N
    subsignal = signal(1+(i-1)*L:i*L);
    
    %Obtencion de métrica
    sub_rms   = rms(subsignal); vec_rms(i) = sub_rms;
    
    %Clasificación
    % 1. RMS
    if (sub_rms < UMBRAL_RMS0)     %S
        vec_vus(i) =  0;    
    elseif (sub_rms < UMBRAL_RMS1) %U
        vec_vus(i) = -1;
    else
        vec_vus(i) =  1;           %V 
    end
    
    %Obtención de parámetros filtro
    A(i,:) = mylpc(subsignal,P);    
end

%2. Proceso de sintesis
synth_signal = [];
for i = 1:N
    if (vec_vus(i) == 1)   %V
        a = A(i,:);
        x = exciteV(L,fs/100); %100Hz
        subsignal = filter(1,a,x);
        
        %Correccion rms
        k_corr = vec_rms(i)/rms(subsignal);
        subsignal = k_corr*subsignal;
        
        synth_signal = [synth_signal subsignal];
    elseif (vec_vus(i) == -1) %U
        a = A(i,:);
        subsignal = filter(1,a,rand(1,L)-1/2);
        
        %Correccion rms
        k_corr = vec_rms(i)/rms(subsignal);
        subsignal = k_corr*subsignal;
        
        synth_signal = [synth_signal subsignal];
    else                   %S
        subsignal = zeros(1,L);
        synth_signal = [synth_signal subsignal];
    end    
end

%%% Gráficos
t = (1:N*L)*1/fs;

figure
plot(t, signal);
hold on
plot(t, synth_signal);
xlabel("Tiempo [s]"); ylabel("Amplitud [-]")
legend("Señal original", "Señal sintetizada")
title(["Coparación entre señal de voz original", "y sintetizada a partir de compresión con LPC"])

% Guardando en audio
audiowrite("test_signal.wav", signal,fs);
audiowrite("my_test_signal.wav", synth_signal,fs);
