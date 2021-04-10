%% Representación Gráfica de señales Sinusoidales

t = 0:2:59;
y = sin(t/6);

subplot 311
g1 = stem(t,y,"r");
grid on;
xlabel("tiempo s"); ylabel("Amplitud");
title("Resultado de stem en señal y(t)")

subplot 312
g2 = plot(t,y, "g"); g2.LineWidth = 2;
grid on
xlabel("tiempo s"); ylabel("Amplitud");
title("Resultado de plot en señal y(t)")

%1
t1 = 0:2*5:59;
y1 = sin(t1/6);
subplot 313
g3 = plot(t1,y1,"b"); g3.LineWidth = 3; hold on
g4 = stem(t1,y1,"m"); g4.LineWidth = 4;
xlim([0 60]);
xlabel("tiempo s"); ylabel("Amplitud");
title("Resultado de plot y stem en señal y(t) con 1/5 de muestras")