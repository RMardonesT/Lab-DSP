%% Lectura del archivo besh.wav

[besh, Fs] = audioread("besh.wav"); %6001 muestras

%% p1_1 extacción de vocal y fricativa
e = besh(1300:3600);
sh = besh(4400:6001);


plot(besh, "b")
hold on
plot(1300:3600,eps, "r")

plot(4400:6001,sh, "black")

%% p1_2
audiowrite("Lab2p1_vocal.wav", eps, Fs);

%% p1_3 Generación a partir de gráfico
audio_from_graph("gtr-jazz.wav", "Lab2p1_arpegio.wav")

%% Funcion
function audio_from_graph(input_name  , output_name)

    [data, Fs] = audioread(input_name);
    
    plot(data)
    
    [x,y] = ginput(2) 
    
    new_signal = data(round(x(1)):round(x(2)));
    
    audiowrite(output_name , new_signal , Fs);
    
end



