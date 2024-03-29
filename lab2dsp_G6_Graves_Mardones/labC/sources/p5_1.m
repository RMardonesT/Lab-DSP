
clear, close all, clc

%% Señal random de 10 muestras
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

%% aliasing_test P = 3
clear all; close all; clc;

P=3;
load("aliasing_test_16_16.mat");

aliasing = aliasing_test';

%% Upsampling
upsampled = [];
N1 = length(aliasing);

for i = 1:N1
     upsampled = horzcat(upsampled, aliasing(i), zeros(1,P-1));
end
%% Filtrado

B = fir1(40, 1/P);
filtered =  filter(B,1,upsampled);

%%
<<<<<<< Updated upstream
mag1 = abs(fftshift(fft(aliasing,N1)));
=======
mag1 = abs(fftshift(fft(aliasing)));
>>>>>>> Stashed changes
w1 = (-N1/2:N1/2-1)/N1*2*pi;

N2 = length(upsampled);
mag2 = abs(fftshift(fft(upsampled,N2)));
w2 = (-N2/2:N2/2-1)/N2*2*pi;

N3 = length(filtered);
mag3 =  abs(fftshift(fft(filtered,N3)));
w3 = (-N3/2:N3/2-1)/N3*2*pi;

%% Graficas de magnitud


subplot(3,1,1)
plot(w1,mag1);
xlabel("Frecuencia normalizada [rad/muestra]")
ylabel("Magnitud [-]")
title("Señal original")
xlim([-2.5,2.5])

subplot(3,1,2)
plot(w2,mag2);
xlabel("Frecuencia normalizada [rad/muestra]")
ylabel("Magnitud [-]")
title("Señal luego de sufrir upsampling")
xlim([-2.5,2.5])

subplot(3,1,3);
plot(w3,mag3);
xlabel("Frecuencia normalizada [rad/muestra]")
ylabel("Magnitud [-]")
title("Resultado luego de sufrir upsampling y filtrado")
xlim([-2.5,2.5])

%% Kronecker

clear all; close all; clc;

t = 0:1:40
delta = double(kroneckerDelta(sym(t),19));

y = interpola(delta,3);


subplot(4,1,1)
stem(delta)
title("Delta de Kronecker")
ylabel("Magnitud")
xlabel("Muestras")

subplot(4,1,2)
stem(y) 
title("Interpolación a Delta de Kronecker considerando retardo de grupo usando  stem")
ylabel("Magnitud")
xlabel("Muestras")


subplot(4,1,3)
stem(y(39:end)) 
title("Interpolación a Delta de Kronecker eliminando retardo de grupo usando  stem")
ylabel("Magnitud")
xlabel("Muestras")

subplot(4,1,4)
plot(y(39:end)) 
title("Interpolación lineal a Delta de Kronecker  usando plot")
ylabel("Magnitud")
xlabel("Tiempo")



