close all;clear;clc;

%1.1
[besh, Fs] = audioread("besh.wav"); %6001 muestras

e = besh(1300:3600);
sh = besh(4400:6001);

plot(besh, "b")
hold on
plot(1300:3600,e, "r")

plot(4400:6001,sh, "black")


audiowrite('Lab2p1_vocal.wav', e, Fs);

%1.2
select_wav('besh.wav','Lab2p1_segmento_vocal.wav');

%% 1.3
select_wav('gtr-jazz_16_48.wav','Lab2p1_arpegio.wav');
%% Funciones
function select_wav(input_name, output_name)
    [signal, Fs] = audioread(input_name);
    figure;plot(signal)
    xlabel('Muestras'); ylabel('Amplitud');
    title('Seleccione 2 instantes para guardar audio')
    [x,~] = ginput(2);
    close
    audiowrite(output_name,signal(round(x(1)):round(x(2))),Fs)
end