% p2
close all; clear; clc
%%%p2.2

[x, Fs] = audioread("gtr-jazz.wav");
Ts = 1/Fs;

%Parámetros delay
audiofile = "gtr-jazz.wav";
outputname = "gtr-jazz_delay-multitap.wav";

N = 4; M = 0.125/Ts;

b =.35*ones(N,1);

% Delay multitap de ganancia cte sobre gtr-jazz
[y, Fs] = delay_multitap(audiofile,outputname, N, M, b); 

figure
plot(x(:,1));
hold on
plot(y(:,1));
ylabel("Amplitud");
xlabel("Muestras");
legend("gtr-jazz.wav original","gtr-jazz.wav con delay multi-tap")
title("Delay multi-tap sobre gtr-jazz.wav");

%% Delay multitap de ganancia exponencial

outputname = "gtr-jazz_delay-multitap2.wav";

Ts = 1/Fs;
N = 10;
M = round(0.250/Ts);
b = zeros(N,1);
for i = 1:N
    b(i)=.35^i;
end

[y, Fs] = delay_multitap(audiofile,outputname, N, M, b);

figure
plot(x(:,1));
hold on
plot(y(:,1));
ylabel("Amplitud");
xlabel("Muestras");
legend("gtr-jazz.wav original","gtr-jazz.wav con delay multi-tap modificado")
title("Delay multi-tap modificado sobre gtr-jazz.wav");

%% Modificación de tasa muestreo
p = 1;
q = 3;
x_16 = resample(x,p,q);

Fs2 = 16000;
T = 1/Fs2;
M = round(0.250/T); %Se divide en 3
audiowrite("gtr-jazz_resample-16.wav",x_16,Fs2);

audiofile = "gtr-jazz_resample-16.wav";
outputname = "gtr-jazz_resample-16_delay.wav";

[y_16,Fs2] = delay_multitap(audiofile,outputname, N, M, b);


function [y,Fs] = delay_multitap(audiofile,outputname, N, M, b)
    
    [x,Fs] = audioread(audiofile);
    
    x_r = x(:,1); x_l = x(:,2); %Separación por canales 
    L = N*M+1;                  %Largo necesario para implementar buffer
    
    buff = zeros(L,1);       %Inicialización buffer
    y_r = zeros(length(x),1);
    
    for n = 1:length(x)
        buff_start = mod(n-1,L)+1;  %Dirección de inicio de buffer circular
        buff(buff_start) = x_r(n); %Actualización de buffer para encontrar y(i)
    
        for k = 1:N
            y_r(n)= y_r(n)+ b(k)*buff(mod(L+buff_start-k*M-1,L)+1);%Aplicación de filtro
        end
    end 
    
    buff = zeros(L,1);       %Inicialización buffer
    y_l = zeros(length(x),1);
    
    for n = 1:length(x)
        buff_start = mod(n-1,L)+1;  %Dirección de inicio de buffer circular
        buff(buff_start) = x_l(n); %Actualización de buffer para encontrar y(i)
    
        for k = 1:N
            y_l(n)= y_l(n)+ b(k)*buff(mod(L+buff_start-k*M-1,L)+1); %Aplicación de filtro
        end
    end
    
    y = [y_l y_r];
    audiowrite(outputname,y,Fs);    
end


