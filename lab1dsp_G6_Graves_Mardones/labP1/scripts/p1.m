%% Representaci�n Gr�fica de se�ales Sinusoidales

t = 0:2:59;
y = sin(t/6);

subplot 311
g1 = stem(t,y,"r");
grid on;
xlabel("tiempo s"); ylabel("Amplitud");
title("Resultado de stem en se�al y(t)")

subplot 312
g2 = plot(t,y, "g"); g2.LineWidth = 2;
grid on
xlabel("tiempo s"); ylabel("Amplitud");
title("Resultado de plot en se�al y(t)")

%1
t1 = 0:2*5:59;
y1 = sin(t1/6);
subplot 313
g3 = plot(t1,y1,"b"); g3.LineWidth = 3; hold on
g4 = stem(t1,y1,"m"); g4.LineWidth = 4;
xlim([0 60]);
xlabel("tiempo s"); ylabel("Amplitud");
title("Resultado de plot y stem en se�al y(t) con 1/5 de muestras")

figure(2)

subplot(2,1,1)
stairs(y)
xlabel("Tiempo "); ylabel("Amplitud");
title("Gr�fica se la se�al y(y) usando el comando stairs(y)")
subplot(2,1,2)
plot(y)
xlabel("Tiempo "); ylabel("Amplitud");
title("Gr�fica se la se�al y(y) usando el comando plot(y)")