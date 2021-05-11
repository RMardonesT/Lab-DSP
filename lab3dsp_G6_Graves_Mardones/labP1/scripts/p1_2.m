%p1_2
close all; clear; clc;

%Ecuacion de diferencia y[n] = 2cos(\theta)ry[n-1] - r^2y[n-2]+(1-r)x[n-2]
N = 50; %Hasta donde se llegará en muestras de y
r = [.99 .9 .7];
theta = pi/3;

x = [0; 0; 1; zeros(N,1)]; %Vector columna con delta en 0 
y1 = zeros(N+3,1);
y2 = zeros(N+3,1);
y3 = zeros(N+3,1);

%Filtrado 
for n = 5:length(y1)
    y1(n) = 2*cos(theta)*r(1)*y1(n-1) - r(1)^2*y1(n-2) + (1-r(1))*x(n-2);
    y2(n) = 2*cos(theta)*r(2)*y2(n-1) - r(2)^2*y2(n-2) + (1-r(2))*x(n-2);
    y3(n) = 2*cos(theta)*r(3)*y3(n-1) - r(3)^2*y3(n-2) + (1-r(3))*x(n-2);
end

figure(1)
subplot 311
stem(-2:N,y1);
xlabel("Muestras");ylabel("Amplitud");
title("Respuesta a impulso de filtro de 2 polos complejos conjugados - r = .99 - \theta = \pi/3")

subplot 312
stem(-2:N,y2);
xlabel("Muestras");ylabel("Amplitud");
title("Respuesta a impulso de filtro de 2 polos complejos conjugados - r = .9 - \theta = \pi/3")

subplot 313
stem(-2:N,y3);
xlabel("Muestras");ylabel("Amplitud");
title("Respuesta a impulso de filtro de 2 polos complejos conjugados - r = .7 - \theta = \pi/3")

%%% Respuestas en frecuencia
N = 100;
wTs = [-N/2:N/2-1]*2*pi/N;
ejw = exp(1j*wTs);


H1 = 1./(ejw.^2 - 2*r(1)*cos(theta)*ejw + r(1)^2);
H2 = 1./(ejw.^2 - 2*r(2)*cos(theta)*ejw + r(2)^2);
H3 = 1./(ejw.^2 - 2*r(3)*cos(theta)*ejw + r(3)^2);

figure(2)
plot(wTs, abs(H1))
hold on
plot(wTs, abs(H2))
plot(wTs, abs(H3))
title("Magnitud de H(e^{j\omega Ts}) de filtro de un par de polos conjugados")
legend("r = .99 \theta = \pi/3","r = .9 \theta = \pi/3","r = .7 \theta = \pi/3")
xlim([-pi pi]);
ylabel("Magnitud");
xlabel("frecuencia angular normalizada [rad/muestra]")

