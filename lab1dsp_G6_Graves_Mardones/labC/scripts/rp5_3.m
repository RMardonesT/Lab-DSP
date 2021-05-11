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

x_m4  = cuantiza(x_m,N(3));
x_m2  = cuantiza(x_m,N(4));
x_m1  = cuantiza(x_m,N(5));

x_v4  = cuantiza(x_v,N(3));
x_v2  = cuantiza(x_v,N(4));
x_v1  = cuantiza(x_v,N(5));

%% 3 Dithering

x_m4_dither  = cuantiza_dither(x_m,N(3));
x_m2_dither  = cuantiza_dither(x_m,N(4));
x_m1_dither  = cuantiza_dither(x_m,N(5));

x_v4_dither  = cuantiza_dither(x_v,N(3));
x_v2_dither  = cuantiza_dither(x_v,N(4));
x_v1_dither  = cuantiza_dither(x_v,N(5));

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