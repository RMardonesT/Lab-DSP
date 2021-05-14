clear all; close all;
%% Filtro FIR

load('nspeech.mat')


%% DTFT
[nspeech_dtft, w_nspeech] = DTFT(nspeech,0);

figure(1)
plot(w_nspeech,(abs(nspeech_dtft)/length(nspeech)))
title('DTFT de la señal de audio')
xlabel('Frecuencia $[\frac{rad}{s}]$','interpreter','latex')
ylabel('Amplitud [-]','interpreter','latex')

%% 

%% Definicion de constantes
r1 = 1;
theta1 =  1.324;   %1.323=1684*pi/(fs/2)%fs=8000;
t = 1/fs:1/fs:length(nspeech)/fs;

H = tf([1 -2*cos(theta1) 1],[1 0 0]);

%%

y_conv = FIR_filter(H,nspeech); 

[y_conv_dtft, w_y_conv] = DTFT(y_conv,0);




figure(2)
plot(w_y_conv,20*log10(abs(y_conv_dtft)/length(nspeech)))
title('DTFT de nspeech filtrado')




%%

function y_conv = FIR_filter(h,x)
    %Parametros del filtro
    [num1, den1] = tfdata(h);  %extrae los polinomios de unan tf
    b = num1{1};
    a = den1{1};
    y_imp = impz(b,a,length(x)); % Respuesta de impulso del filtro digita
    y_conv = conv(y_imp,x);    %convolucion de el filtro con la entrada x 

end 

function [X,w] = DTFT(x,M)
% This function computes samples of the DTFT of x. 
% To compute the DTFT of x, use
%
%             [X,w] = DTFT(x,0)
%
% where X is the vector of DTFT samples and w is the 
% vector of radial frequencies. To compute at least
% M samples of the DTFT, you may use the command
%
%             [X,w] = DTFT(x,M)
%
% This is useful when the plot of X versus w does
% not contain a sufficient number of points.

N = max(M,length(x));
N = 2^(ceil(log(N)/log(2)));

% Take the padded fft
X = fft(x,N);
w = 2*pi*( (0:(N-1))/N );
w = w - 2*pi*(w>=pi);

% Shift FFT to go from -pi to pi
X = fftshift(X);
w = fftshift(w);
end