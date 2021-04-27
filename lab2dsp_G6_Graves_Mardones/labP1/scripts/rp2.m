close all; clear; clc

%2.1
[gtr, Fs] = audioread("gtr-jazz_16_48.wav");

alpha = .2; beta = .05; Gi = 1; Go = 1;
%%
gtr_ov = overdrive(gtr, alpha, beta, Gi, Go); 
audiowrite('gtr-ov_a02b005Gi1Go1.wav',gtr_ov,Fs);

figure
plot(gtr(:,1));hold on; plot(gtr_ov(:,1));
xlabel("Muestras"); ylabel("Amplitud"); 
title("Comparación visual de audio luego de aplicar overdrive")
legend('Original','Con overdrive')

function y = overdrive(x,alpha,beta,Gi,Go)
    x2 = Gi*x;      %Se supone x normalizado
    [rows,cols] = size(x);
    y2 = zeros(rows,cols); %Inicialización del vector
    
    for i = 1:rows
        for j = 1:cols
            if abs(x2)>= alpha
                y2(i,j) = beta*x2(i,j) + sign(x2(i,j))*(1-beta)*alfa; 
            else
                y2(i,j)=x2(i,j);
            end
        end
    end
    y = Go*y2;
end