function [y,Fs] = delay_multitap(audiofile,outputname, N, M, b)
    
    [x,Fs] = audioread(audiofile);
    
    x_r = x(:,1); x_l = x(:,2); %Separacion por canales 
    L = N*M+1; %Largo necesario para implementar buffer
    
    buff = zeros(L,1);       %Inicializacion buffer
    y_r = zeros(length(x),1);
    
    for n = 1:length(x)
        buff_start = mod(n-1,L)+1;  %Dir de inicio de buffer circ
        buff(buff_start) = x_r(n);  %Actualizacion de buffer 
    
        for k = 1:N
            y_r(n)= y_r(n)+b(k)*buff(mod(L+buff_start-k*M-1,L)+1);
            %Aplicacion de filtro
        end
    end 
    
    buff = zeros(L,1);       %Inicializacion buffer
    y_l = zeros(length(x),1);
    
    for n = 1:length(x)
        buff_start = mod(n-1,L)+1;  %Dir de inicio de buffer circ
        buff(buff_start) = x_l(n); %Actualizacion de buffer
    
        for k = 1:N
            y_l(n)= y_l(n)+b(k)*buff(mod(L+buff_start-k*M-1,L)+1); 
            %Aplicacion de filtro
        end
    end
    
    y = [y_l y_r];
    audiowrite(outputname,y,Fs);    
end


