close all; clear all; clc;

dt= 0.01;
t =-1:dt:1-dt;
N=length(t);

ejex = (1:5)-11;
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
    
    angle = theta(i);
    for n=3:1:N
        impulso_rec(n)= delta(n) - 2*cos(angle)*delta(n-1) + delta(n-2);
    end
    
    subplot(3,1,i)
    plot(t,impulso_rec)
    hold on 
    stem(t,impulso_rec)
    xlim([-0.05, 0.05])
    title("Respuesta a impulso del filtro con \omega = "+ str_theta(i), "FontSize",16);
    xlabel('Muestras','FontSize',14)
    ylabel("Magnitud", "FontSize",14)
    
           
end


%%  Magnitud de la respuesta impulso 
title("Magnitud respuesta en frecuencia |H(\omega)| \theta ="+ str_theta(i))
for  i=1:1:3
    
    angle = theta(i);
    for n=3:1:N
        impulso_rec(n)= delta(n) - 2*cos(angle)*delta(n-1) + delta(n-2);
    end
    
    
    [magX,magXdb,w] = plot_mag(impulso_rec,N)
    
    if i == 1
        subplot(3,2,1)
        plot(w,magX)
        title("Magnitud respuesta en frecuencia |H(\omega)| \theta ="+ str_theta(i),"FontSize", 22)
        xlabel("Frecuencia normalizada [rad/s]","FontSize", 20)
        ylabel("Magnitud [-]","FontSize", 20)
        
        subplot(3,2,2)
        plot(w,magXdb)
        title("Magnitud respuesta en frecuencia 20log_{10}|H(\omega)| en dB \theta ="+ str_theta(i),"FontSize", 22)
        xlabel("Frecuencia normalizada [rad/s]","FontSize", 20)
        ylabel("Magnitud [dB]","FontSize", 20)      
    end
    
   if i == 2
        subplot(3,2,3)
        plot(w,magX)
        title("Magnitud respuesta en frecuencia |H(\omega)| \theta ="+ str_theta(i),"FontSize", 22)
        xlabel("Frecuencia normalizada [rad/s]","FontSize", 20)
        ylabel("Magnitud [-]","FontSize", 20)
            
        
        subplot(3,2,4)
        plot(w,magXdb)
        title("Magnitud respuesta en frecuencia 20log_{10}|H(\omega)| en dB \theta ="+ str_theta(i),"FontSize", 22)
        xlabel("Frecuencia normalizada [rad/s]","FontSize", 20)
        ylabel("Magnitud [dB]","FontSize", 20)      
   end
   
       if i == 3
        subplot(3,2,5)
        plot(w,magX)
        title("Magnitud respuesta en frecuencia |H(\omega)| \theta ="+ str_theta(i),"FontSize", 22)
        xlabel("Frecuencia normalizada [rad/s]","FontSize", 20)
        ylabel("Magnitud [-]","FontSize", 20)
             
        
        subplot(3,2,6)
        plot(w,magXdb)
        title("Magnitud respuesta en frecuencia 20log_{10}|H(\omega)| en dB \theta ="+ str_theta(i),"FontSize", 22)
        xlabel("Frecuencia normalizada [rad/s]","FontSize", 20)
        ylabel("Magnitud [dB]","FontSize", 20)
    end
    
    
  
end

%% Superpuesta
%%  Magnitud de la respuesta impulso 
title("Magnitud respuesta en frecuencia |H(\omega)| \theta ="+ str_theta(i))
for  i=1:1:3
    
    angle = theta(i);
    for n=3:1:N
        impulso_rec(n)= delta(n) - 2*cos(angle)*delta(n-1) + delta(n-2);
    end
    
    
    [magX,magXdb,w] = plot_mag(impulso_rec,N)
    
    subplot(2,1,1)
    plot(w,magX)
    title("Magnitud respuesta en frecuencia |H(\omega)|","FontSize", 20)
    xlabel("Frecuencia normalizada [rad/s]","FontSize", 18)
    ylabel("Magnitud [-]","FontSize", 18)
    legend( "\theta ="+ str_theta,"FontSize",16)
    hold on 
    
    subplot(2,1,2)
    plot(w,magXdb)
    title("Magnitud respuesta en frecuencia 20log_{10}|H(\omega)| en dB","FontSize", 20)
    xlabel("Frecuencia normalizada [rad/s]","FontSize", 18)
    ylabel("Magnitud [dB]","FontSize", 18)
    legend( "\theta ="+ str_theta,"FontSize",16)
    hold on 
    

  
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