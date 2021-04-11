%% Generación de Señales
close all; clear; clc;

%% 4
fs = [2000 10000 44000];

%Generacion señal determinística
N  = fs(1)*1; %fs * Tiempo de duración
n  = 0:N-1 ; %Vector de muestras
s500 = sin(2*pi*(500/fs(1))*n); %señal de 500Hz muestreada a fs

subplot 221
plot(n/fs(1),s500); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");title("Señal s_{500}(t) vs tiempo")

% Señal aleatoria 1 (2kHz)
N = fs(1)*1;                    %fs * Tiempo de duración
n = 0:N-1  ;                    %Vector de muestras
rand_v = 2*rand(1,N)-1;
s500 = sin(2*pi*(500/fs(1))*n); %señal de 500Hz muestreada a fs
s4_2k = s500+rand_v;

subplot 222
plot(n/fs(1),s4_2k); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");
title({"Señal s_{500}(t) vs tiempo con ruido aleatorio", "uniforme [-1,1] muestreado a 2kHz"})

% Señal aleatoria 2 (10 kHz)
N = fs(2)*1;                    %fs * Tiempo de duración
n = 0:N-1  ;                    %Vector de muestras
rand_v = 2*rand(1,N)-1;
s500 = sin(2*pi*(500/fs(2))*n); %señal de 500Hz muestreada a fs
s4_10k = s500+rand_v;

subplot 223
plot(n/fs(2),s4_10k); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");
title({"Señal s_{500}(t) vs tiempo con ruido aleatorio", "uniforme [-1,1] muestreado a 10kHz"})

% Señal aleatoria 3 (44 kHz)
N = fs(3)*1;                    %fs * Tiempo de duración
n = 0:N-1  ;                    %Vector de muestras
rand_v = 2*rand(1,N)-1;
s500 = sin(2*pi*(500/fs(3))*n); %señal de 500Hz muestreada a fs
s4_44k = s500+rand_v;

subplot 224
plot(n/fs(3),s4_44k); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");
title({"Señal s_{500}(t) vs tiempo con ruido aleatorio", "uniforme [-1,1] muestreado a 44kHz"})

%% 5
N  = fs(3)*1; %fs * Tiempo de duración
n  = 0:N-1 ; %Vector de muestras

rand_v = 1/2*rand(1,N)+.5; % Uniforme [.5; 1]

s5 = rand_v.*s500;

figure(2)
subplot 211
plot(n/fs(3),s500); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");title("Señal s_{500}(t) vs tiempo")
subplot 212
plot(n/fs(3),s5); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");
title({"Señal s_{500}(t) con amplitud aleatoria uniforme [0.5 ,1]", "vs tiempo, muestreado a 44kHz"})

%% 6
N  = fs(3)*1; %fs * Tiempo de duración
n  = 0:N-1 ; %Vector de muestras

rand_v = pi*rand(1,N)-pi/2; % Uniforme [-pi/2; pi/2]

s6 = sin(2*pi*(500/fs(3))*n + rand_v);

figure(3)
subplot 211
plot(n/fs(3),s500); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");title("Señal s_{500}(t) vs tiempo")
subplot 212
plot(n/fs(3),s6); xlim([0 0.01]);
xlabel("tiempo s");ylabel("Amplitud");
title({"Señal s_{500}(t) con fase aleatoria uniforme [-\pi/2 ,\pi/2]", "vs tiempo, muestreado a 44kHz"})

%% 7 
%soundsc(s4_44k,fs(3));
%soundsc(s5,fs(3));
%soundsc(s6,fs(3));