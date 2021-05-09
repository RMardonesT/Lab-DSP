close all; clear; clc

%2.1
[gtr, Fs] = audioread("gtr-jazz_16_48.wav");

alpha = .2; beta = .05; Gi = 1; Go = 1;

gtr_ov = overdrive('gtr-jazz_16_48.wav', alpha, beta, Gi, Go); 
audiowrite('gtr-ov_a02b005Gi1Go1.wav',gtr_ov,Fs);

musica_ov = overdrive('gtr-jazz_16_48.wav', alpha, beta, Gi, Go); 
audiowrite('musica_16-44p1.wav',gtr_ov,Fs);

figure
plot(gtr(:,1));hold on; plot(gtr_ov(:,1));
xlabel("Muestras"); ylabel("Amplitud"); 
title("Comparación visual de audio luego de aplicar overdrive")
legend('Original','Con overdrive')

%% Relación entrada-salida alpha 0.1 y Gi = 3

x = -0.5:0.002:0.5;
N = length(x);
y = zeros(N,1);

%Caso alpha = 0.1
alpha = .1;
x2 = Gi*x;
for i = 1:N
    if abs(x2(i)) >= alpha
        y(i) = beta*x2(i) +  sign(x2(i))*(1-beta)*alpha;
    else
        y(i) = x2(i);
    end      
end
y = Go*y;

figure; plot(x,y); hold on; xlabel("x");ylabel("y");
title("Relación salida/entrada de overdrive")

%Caso Gi = 3
Gi = 3; alpha = .2;
x2 = Gi*x;
for i = 1:N
    if abs(x2(i)) >= alpha
        y(i) = beta*x2(i) +  sign(x2(i))*(1-beta)*alpha;
    else
        y(i) = x2(i);
    end      
end
y = Go*y;

plot(x,y);xlabel("x");ylabel("y");
title("Relación salida/entrada de overdrive")
legend("\alpha = .1, \beta = .05, G_i = 1, G_o = 1",...
       "\alpha = .2, \beta = .05, G_i = 3, G_o = 1")
axis on


function  y = overdrive(file_name, alpha, beta, Gi,G0)

    [signal, Fs] = audioread(file_name); 

    %separar canales
    ch1 = signal(:,1);
    ch2 = signal(:,2);
    
    %x2 para cada canal
    x2_ch1 = Gi*ch1;
    x2_ch2 = Gi*ch2;

    %y2 para cada canal lleno de ceros inicialmente
    y2_ch1= zeros(length(signal),1);
    y2_ch2= zeros(length(signal),1);
    
    %y de salida
    y = [y2_ch1 , y2_ch2];

    for i  = 1:length(signal)
        i

        %canal 1
        if abs(x2_ch1(i)) >= alpha

            y2_ch1(i) = beta*x2_ch1(i) +  sign(x2_ch1(i))*(1-beta)*alpha;
        else
            y2_ch1(i) = x2_ch1(i);
        end
        %canal 2
        if abs(x2_ch2(i)) >= alpha

            y2_ch2(i) = beta*x2_ch2(i) +  sign(x2_ch2(i))*(1-beta)*alpha;
        else
            y2_ch2(i) = x2_ch2(i);
        end
    end
    y = [y2_ch1 , y2_ch2];
end