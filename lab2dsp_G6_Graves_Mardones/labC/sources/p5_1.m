
clear, close all, clc
x = rand(10,1);
P = 7;
y = interpola(x,P);

main_samples = (0:P : P*9); %muestras avanzando en de P en  P hasta 10 muestras

subplot(2,1,1)
stem(y(1:end))  
hold on
stem(main_samples,x)

title("Señal aleatoria de 10 muestras generada y su interpolación")
legend("Muestras interpoladas con retardo de grupo", "Muestras se la señal original")


subplot(2,1,2)
stem(y(22:end))  
hold on
stem(main_samples, x) 
xlabel("Muestras")
ylabel("Magnitud")
title("Señal aleatoria de 10 muestras generada y su interpolación")
legend("Muestras interpoladas sin retardo de grupo", "Muestras se la señal original")

%%Función de interpolación

function y = interpola(x,P)
    y = [];
    N = length(x);

    for i = 1:N
        y = horzcat(y, x(i), zeros(1,P-1));
    end

    B = fir1(40, 1/P);
    y = filter(B,1,y);
    
    y = P*y; %corrección de magnitud
end