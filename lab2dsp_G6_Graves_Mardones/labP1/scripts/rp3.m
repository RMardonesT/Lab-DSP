% p2
close all; clear; clc
%%%p2.2

[x, Fs] = audioread("gtr-jazz.wav");
Ts = 1/Fs;

%Par�metros delay
N = 4;
M =0.125/Ts;
b = .35;

x_r = x(:,1);x_l = x(:,2); %Separaci�n por canales 
L = N*M+1;                 %Largo necesario para implementar buffer

buff = zeros(L,1);       %Inicializaci�n buffer
y_r = zeros(length(x),1); 
for n = 1:length(x)
    buff_start = mod(n-1,L)+1;  %Direcci�n de inicio de buffer circular
    buff(buff_start) = x_r(n); %Actualizaci�n de buffer para encontrar y(i)
    
    for k = 1:N
        y_r(n)= y_r(n)+ b*buff(mod(L+buff_start-k*M-1,L)+1); %Aplicaci�n de filtro
    end
end 

buff = zeros(L,1);       %Inicializaci�n buffer
y_l = zeros(length(x),1); 
for n = 1:length(x)
    buff_start = mod(n-1,L)+1;  %Direcci�n de inicio de buffer circular
    buff(buff_start) = x_l(n); %Actualizaci�n de buffer para encontrar y(i)
    
    for k = 1:N
        y_l(n)= y_l(n)+ b*buff(mod(L+buff_start-k*M-1,L)+1); %Aplicaci�n de filtro
    end
end 

audiowrite('gtr-jazz_delay-multitap.wav',[y_r y_l], Fs);


