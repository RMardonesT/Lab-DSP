%% Overdrive
clear all; clc;

y_1 = overdrive("gtr-jazz.wav",0.2, 0.05, 1,1 );
y_2 = overdrive("gtr-jazz.wav",0.1, 0.05, 3 ,1 )


%%

function  y = overdrive(file_name, alpha, beta, Gi,G0)

    [signal, Fs] = audioread(file_name); 

    %separar canales
    ch1 = signal(:,1);
    ch2 = signal(:,2);
    
    %x2 para cada canal
    x2_ch1 = Gi*ch1;
    x2_ch2 = Gi*ch2;

    %y2 para cada canal lleno de ceros inicialmente
    y2_ch1= zeros(length(signal),1);
    y2_ch2= zeros(length(signal),1);
    
    %y de salida
    y = [y2_ch1 , y2_ch2];

    for i  = 1:length(signal)
        i

        %canal 1
        if abs(x2_ch1(i)) >= alpha

            y2_ch1(i) = beta*x2_ch1(i) +  sign(x2_ch1(i))*(1-beta)*alpha;
        else
            y2_ch1(i) = x2_ch1(i);
        end
        %canal 2
        if abs(x2_ch2(i)) >= alpha

            y2_ch2(i) = beta*x2_ch2(i) +  sign(x2_ch2(i))*(1-beta)*alpha;
        else
            y2_ch2(i) = x2_ch2(i);
        end




    end

    y = [y2_ch1 , y2_ch2];
end


