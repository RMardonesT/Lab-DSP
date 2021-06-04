clear all; clc;

%% Definiciones
titleSize = 24;
labelSize = 22;

M = 1024;
N1 = 21; % Largo del Sinc
N2 = 101;
N3 = 1001;
wc = 2*pi/3; % Frecuecia de corte del filtro
n1 = 0:1:(N1-1); % Muestras del Sinc
n2 = 0:1:(N2-1);
n3 = 0:1:(N3-1);

%%
h1 = (wc/pi)*sinc((wc/pi)*(n1 - (N1-1)/2));
h2 = (wc/pi)*sinc((wc/pi)*(n2 - (N2-1)/2));
h3 = (wc/pi)*sinc((wc/pi)*(n3 - (N3-1)/2));
[X1, w1] = DTFT(h1,M);
[X2, w2] = DTFT(h2,M);
[X3, w3] = DTFT(h3,M);

%% Graficos
subplot(3,3,1)
plot(n1,h1);
title("h[n] con N=21", "FontSize",titleSize);
ylabel("Magnitud [-]", "FontSize",labelSize);
xlabel("Muestras")

subplot(3,3,2)
plot(w1, (abs(X1)))
title("Magnitud de H(\omega) N=21", "FontSize",titleSize);
ylabel("Magnitud [-]", "FontSize",labelSize);
xlabel("Frecuencia rad/s", "FontSize",labelSize);
xlim([-pi pi])

subplot(3,3,3)
plot(w1, unwrap(angle(X1)))
title('Fase de H(\omega) N=21', "FontSize",titleSize);
xlabel("Frecuencia rad/s", "FontSize",labelSize);
ylabel('Fase [rad]', "FontSize",labelSize);
xlim([-pi pi])

subplot(3,3,4)
plot(n2,h2);
title("h[n] con N=101", "FontSize",titleSize);
ylabel("Magnitud [-]", "FontSize",labelSize);
xlabel("Muestras", "FontSize",labelSize);



subplot(3,3,5)
plot(w2, abs(X2))
title('Magnitud de H(\omega) N=101',"FontSize",titleSize);
ylabel('Magnitud [-]', "FontSize",labelSize);
xlabel("Frecuencia rad/s", "FontSize",labelSize);
xlim([-pi pi])

subplot(3,3,6)
plot(w2, unwrap(angle(X2)))
title('Fase de H(\omega) N=101', "FontSize",titleSize);
xlabel("Frecuencia rad/s", "FontSize",labelSize);
ylabel('Fase [rad]', "FontSize",labelSize);
xlim([-pi pi])


subplot(3,3,7)
plot(n3,h3);
title("h[n] con N=1001", "FontSize",titleSize);
ylabel("Magnitud [-]", "FontSize",labelSize);
xlabel("Muestras", "FontSize",labelSize);

subplot(3,3,8)
plot(w3, abs(X3))
title('Magnitud de H(\omega) N=1001',"FontSize",titleSize);
ylabel('Magnitud [-]', "FontSize",labelSize);
xlabel("Frecuencia rad/s", "FontSize",labelSize);
xlim([-pi pi])

subplot(3,3,9)
plot(w3, unwrap(angle(X3)))
title('Fase de H(\omega) N=1001',"FontSize",titleSize);
xlabel("Frecuencia rad/s", "FontSize",labelSize);
ylabel('Fase [rad]', "FontSize",labelSize);
xlim([-pi pi])
