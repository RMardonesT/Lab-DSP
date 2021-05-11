close all; clear all; clc;

dt= 0.01;
t =-1:dt:1-dt;
N=length(t);

ejex = (1:20)-11;
%% Generación del impulso

delta=dirac(t);
Dx = delta ==inf;
delta(Dx) = 1;
%% filtro  y[n] = x[n] -2cos(theta)x[n-1] + x[n-2]

impulso_rec = zeros(1,N);
theta = [pi/6,pi/3, pi/2];
str_theta = ["\pi/6", "\pi/3", "\pi/2"];

 %% respuesta impulso de filtro recursivo y mediante "filter"
for  i=1:1:3
    figure(i)
    angle = theta(i);
    for n=3:1:N
        impulso_rec(n)= delta(n) - 2*cos(angle)*delta(n-1) + delta(n-2);
    end
    
    figure(i)
    plot(t, impulso_rec);
    xlim([-0.2, 0.2])
    title("Respuesta a impulso del filtro con \omega = \pi/6");
    
           
end

%%  Magnitud de la respuesta impulso 

for  i=1:1:3
    figure(i)
    angle = theta(i);
    for n=3:1:N
        impulso_rec(n)= delta(n) - 2*cos(angle)*delta(n-1) + delta(n-2);
    end
    
    num = [1 -2*cos(angle) 1];
    den = [1 0 0];
    impulso_rec = filter(num,den,delta)
           
end
%% funcion grafica de magnitud

function [mag_X,mag_db,w]  = plot_mag(x,N)
X_fft = fft(x,N);       %FFT de la entrada 
X_ffts = fftshift(X_fft); % centrrar la fft

mag_X = abs(X_ffts)  % magnitud de la fft

w = 2*pi*( (0:(N-1))/N );  %vector de frecuencias
w = w - 2*pi*(w>=pi);       
w = fftshift(w);

mag_db = 20*log10(mag_X);  %magnitud en decibeles
y = [mag_X,mag_db, w]; 
end