%%%%% LAB 5 DSP Parte 3
close all;clear; clc
load test_training_signals.mat

%%% Parte 3.1
signal = training_signal;
%soundsc(x, fs);
N = length(signal);
t = (0:N-1)/fs;

figure
plot(t,signal)
hold on
xlabel("tiempo [s]"); ylabel("Amplitud")
title("Señal training\_signal vs tiempo")

%[x,y] = ginput(20);
load subdivisiones.mat
x = [0;x];

rms_sig       = zeros(20,1);
cruces_ratio  = zeros(20,1); 

n2 = 0;
for i = 1:19
    n1 = x(i)*fs + 1;
    n2 = x(i+1)*fs + 1;
    t = (n1:n2)/fs;
    plot(t,signal(n1:n2));
    rms_sig(i) = rms(signal(n1:n2));
    cruces_ratio(i) = cruces_zero(signal(n1:n2),fs);
end
legend('silencio','silencio','s','e','ñ','a','l','e','s','silencio','t','e','m','p','o','r','a','l','e','s')


rms_sig(20) = rms(signal(n2:end));
cruces_ratio(20) = cruces_zero(signal(n2:end),fs);

index_s = [1              9                               20];
index_v = [    3  5   7        11       14    16    18      ];
index_u = [  2   4  6   8   10    12 13    15    17    19   ];

rms_s = rms_sig(index_s);
rms_v = rms_sig(index_v);
rms_u = rms_sig(index_u);

cruces_s = cruces_ratio(index_s);
cruces_v = cruces_ratio(index_v);
cruces_u = cruces_ratio(index_u);

figure
stem(index_s, rms_s)
hold on
stem(index_v, rms_v)
stem(index_u, rms_u)
legend('s','v','u')
xlabel("indice sonido [-]")
ylabel("Valor RMS")
title("Valor rms de sonidos diferenciados en training\_test.mat")

figure
stem(index_s, cruces_s)
hold on
stem(index_v, cruces_v)
stem(index_u, cruces_u)
legend('s','v','u')
xlabel("indice sonido [-]")
ylabel("Razón de cruces por 0 [cruce/ms]")
title("Ratio de cruces por cero de sonidos diferenciados en training\_test.mat")