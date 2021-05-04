% p2
close all; clear; clc
%%%p2.2

[x, Fs] = audioread("gtr-jazz.wav");
Ts = 1/Fs;

%Parámetros delay
N = 4;
M =0.125/Ts;
b = .35;

x_r = x(:,1);x_l = x(:,2); %Separación por canales 
L = N*M+1;                 %Largo necesario para implementar buffer

buff = zeros(L,1);       %Inicialización buffer
y_r = zeros(length(x),1); 
for n = 1:length(x)
    buff_start = mod(n-1,L)+1;  %Dirección de inicio de buffer circular
    buff(buff_start) = x_r(n); %Actualización de buffer para encontrar y(i)
    
    for k = 1:N
        y_r(n)= y_r(n)+ b*buff(mod(L+buff_start-k*M-1,L)+1); %Aplicación de filtro
    end
end 

buff = zeros(L,1);       %Inicialización buffer
y_l = zeros(length(x),1); 
for n = 1:length(x)
    buff_start = mod(n-1,L)+1;  %Dirección de inicio de buffer circular
    buff(buff_start) = x_l(n); %Actualización de buffer para encontrar y(i)
    
    for k = 1:N
        y_l(n)= y_l(n)+ b*buff(mod(L+buff_start-k*M-1,L)+1); %Aplicación de filtro
    end
end 

audiowrite('gtr-jazz_delay-multitap.wav',[y_r y_l], Fs);


