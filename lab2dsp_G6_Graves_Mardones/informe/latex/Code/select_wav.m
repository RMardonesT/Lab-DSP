function select_wav(input_name, output_name)
    [signal, Fs] = audioread(input_name);
    figure;plot(signal)
    xlabel('Muestras'); ylabel('Amplitud');
    title('Seleccione 2 instantes para guardar audio')
    [x,~] = ginput(2);
    close
    wav = signal(round(x(1)):round(x(2)));
    audiowrite(output_name,wav,Fs)
end