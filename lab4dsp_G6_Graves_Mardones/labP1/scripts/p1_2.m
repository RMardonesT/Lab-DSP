n = 0:1:500;
N = 4096;
fs = 5000;

x1 = sin(2*pi*n/50);
x2 = cos(2*pi*n/50);

X1 = abs(fft(x1,N));
X2 = abs(fft(x2,N));


%Gráficas entre +-fs/2
figure(1)
subplot(2,1,1)
plot([-fs/2:fs/N:fs/2-1],fftshift(X1));
title("FFT de x1 con N = 4096 entre [-fs/2,fs/2]")
xlabel("rad/muestra")
ylabel("Magnitud ")

subplot(2,1,2)
plot([-fs/2:fs/N:fs/2-1], fftshift(X2));
title("FFT de x2 con N = 4096 entre [-fs/2,fs/2])")
xlabel("rad/muestra")
ylabel("Magnitud ")
%% Gráficas entre 0 y fs

figure(2)

subplot(2,1,1)
plot([0:fs/4096:fs-1], X1)
title("FFT de x1 con N = 4096 entre [0,fs]")
xlabel("rad/muestra")
ylabel("Magnitud ")

subplot(2,1,2)
plot([0:fs/4096:fs-1], X2)
title("FFT de x2 con N = 4096 entre [0,fs]")
xlabel("rad/muestra")
ylabel("Magnitud ")


