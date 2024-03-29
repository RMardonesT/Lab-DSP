%% p5
close all; clear; clc;

%Importación de audios a workspace
[x_m,Fs_m] = audioread("musica_16_16.wav");
[x_v,Fs_v] = audioread("sonidos_voz_16_16.wav");

%sound(x_m,Fs_m);
%pause(6);
%sound(x_v,Fs_v);

%% 1 Cuantización b = 12,8,4,2 y 1
b = [12 8 4 2 1];
N = 2.^b;

x_m12 = cuantiza(x_m,N(1));
x_m8  = cuantiza(x_m,N(2));
x_m4  = cuantiza(x_m,N(3));
x_m2  = cuantiza(x_m,N(4));
x_m1  = cuantiza(x_m,N(5));

x_v12 = cuantiza(x_v,N(1));
x_v8  = cuantiza(x_v,N(2));
x_v4  = cuantiza(x_v,N(3));
x_v2  = cuantiza(x_v,N(4));
x_v1  = cuantiza(x_v,N(5));

%% 2 Cuantiza2

% 2a
[x_m12, e_m12] = cuantiza2(x_m,N(1));
[x_m8,  e_m8 ] = cuantiza2(x_m,N(2));
[x_m4,  e_m4 ] = cuantiza2(x_m,N(3));
[x_m2,  e_m2 ] = cuantiza2(x_m,N(4));
[x_m1,  e_m1 ] = cuantiza2(x_m,N(5));

[x_v12, e_v12] = cuantiza2(x_v,N(1));
[x_v8,  e_v8 ] = cuantiza2(x_v,N(2));
[x_v4,  e_v4 ] = cuantiza2(x_v,N(3));
[x_v2,  e_v2 ] = cuantiza2(x_v,N(4));
[x_v1,  e_v1 ] = cuantiza2(x_v,N(5));

figure(1) %Agregar legend
subplot 211
plot(x_m2); hold on; plot(x_m)
xlabel("Muestras");ylabel("Amplitud");
title("Efecto de cuantización sobre ")

subplot 212 %Agregar legend
plot(x_v2); hold on; plot(x_v)
xlabel("Muestras");ylabel("Amplitud");

% 2b
figure(2)
subplot 211
hist(e_m12,20)
title("Histograma de error de cuantización usando 12 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
hist(e_v12,20)
title("Histograma de error de cuantización usando 12 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(3)
subplot 211
hist(e_m8,20)
title("Histograma de error de cuantización usando 8 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
hist(e_v8,20)
title("Histograma de error de cuantización usando 8 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(4)
subplot 211
hist(e_m4,20)
title("Histograma de error de cuantización usando 4 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
hist(e_v4,20)
title("Histograma de error de cuantización usando 4 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(5)
subplot 211
hist(e_m2,20)
title("Histograma de error de cuantización usando 2 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
hist(e_v2,20)
title("Histograma de error de cuantización usando 2 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(6)
subplot 211
hist(e_m1,20)
title("Histograma de error de cuantización usando 1 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
hist(e_v1,20)
title("Histograma de error de cuantización usando 1 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

% 2c

[r_m12,l_m12] = xcorr(e_m12,200,"unbiased");
[r_m8, l_m8]  = xcorr(e_m8,200,"unbiased");
[r_m4, l_m4]  = xcorr(e_m4,200,"unbiased");
[r_m2, l_m2]  = xcorr(e_m2,200,"unbiased");
[r_m1, l_m1]  = xcorr(e_m1,200,"unbiased");

[r_v12,l_v12] = xcorr(e_v12,200,"unbiased");
[r_v8, l_v8]  = xcorr(e_v8,200,"unbiased");
[r_v4, l_v4]  = xcorr(e_v4,200,"unbiased");
[r_v2, l_v2]  = xcorr(e_v2,200,"unbiased");
[r_v1, l_v1]  = xcorr(e_v1,200,"unbiased");

figure(7)
subplot 211
plot(l_m12, r_m12)
title("Autocorrelación de error de cuantización usando 12 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
plot(l_v12, r_v12)
title("Autocorrelación de error de cuantización usando 12 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(8)
subplot 211
plot(l_m8, r_m8)
title("Autocorrelación de error de cuantización usando 8 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
plot(l_v8, r_v8);
title("Autocorrelación de error de cuantización usando 8 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(9)
subplot 211
plot(l_m4, r_m4)
title("Autocorrelación de error de cuantización usando 4 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
plot(l_v4, r_v4)
title("Autocorrelación de error de cuantización usando 4 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(10)
subplot 211
plot(l_m2, r_m2)
title("Autocorrelación de error de cuantización usando 2 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
plot(l_v2, r_v2)
title("Autocorrelación de error de cuantización usando 2 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")

figure(11)
subplot 211
plot(l_m1, r_m1)
title("Autocorrelación de error de cuantización usando 1 bits - musica\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
subplot 212
plot(l_v1, r_v1)
title("Autocorrelación de error de cuantización usando 1 bits - sonidos_voz\_16\_16.wav");
xlabel("Amplitud");ylabel("Muestras")
%% Functions
function x_q = cuantiza(x,N)
    delta = (max(x)- min(x))/(N - 1);
    x_q = round((x - min(x))/delta);    
end 

function [x_q,e] = cuantiza2(x,N)
    delta = (max(x)- min(x))/(N - 1);
    x_q = round((x - min(x))/delta)*delta + min(x); 
    e = x_q-x;
end 

function x_q = cuantiza_dither(x,N)
    delta = (max(x)- min(x))/(N - 1);
    x2 = x + 0.25*delta*randn(length(x),1);
    delta = (max(x2)- min(x2))/(N - 1);
    x_q = round((x2 - min(x2))/delta); 
end 