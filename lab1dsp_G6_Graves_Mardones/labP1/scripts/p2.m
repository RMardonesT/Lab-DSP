%% Muestreo

%Generación de Señales
Ts1 = .1  ; n1 = 0:100; s1 = sin(2*pi*Ts1*n1);
Ts2 = 1/3 ; n2 = 0:30 ; s2 = sin(2*pi*Ts2*n2);
Ts3 = .5  ; n3 = 0:20 ; s3 = sin(2*pi*Ts3*n3);
Ts4 = 10/9; n4 = 0:9  ; s4 = sin(2*pi*Ts4*n4);

subplot 221
stem(n1,s1);
xlim([0 100]);ylim([-1 1]);
xlabel("Muestras");ylabel("Amplitud");
title("Gráfico de señal s_1[n] utilizando stem")

subplot 222
stem(n2,s2);
xlim([0 30]);ylim([-1 1]);
xlabel("Muestras");ylabel("Amplitud");
title("Gráfico de señal s_2[n] utilizando stem")

subplot 223
stem(n3,s3);
xlim([0 20]);ylim([-1 1]);
xlabel("Muestras");ylabel("Amplitud");
title("Gráfico de señal s_3[n] utilizando stem")

subplot 224
stem(n4,s4);
xlim([0 9]);ylim([-1 1]);
xlabel("Muestras");ylabel("Amplitud");
title("Gráfico de señal s_4[n] utilizando stem")
