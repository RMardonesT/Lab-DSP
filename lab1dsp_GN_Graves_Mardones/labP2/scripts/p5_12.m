clear all;
%% Lectura de archivos
[data1,fs] = audioread("musica_16_16.wav");
[data2,fs] = audioread("sonidos_voz_16_16.wav");

%% Parte 1
new_data1 = cuantiza(data1,2);
new_data2 = cuantiza(data2,2);

%soundsc(new_data1,fs)
%soundsc(new_data2,fs)

bits = [1 2 4 8 12];

% for i = 1:5
%     N = 2^bits(i);
%     fprintf('%i\n', i, bits(i))
%     N_data = cuantiza(data1,N);
%     soundsc(N_data,fs);
%     pause(6);
%     
% end

for i = 1:5
    N = 2^bits(i);
    N_data = cuantiza(data2,N);
    soundsc(N_data,fs);
    pause(3);
    
end


%% Parte 2 a
N = 2^2;

[y,e] = cuantiza2(data1,N);
[y2,e2] = cuantiza2(data2,N);

%Gráficas para musica_16_16

% subplot(2,1,1)
% plot(y)     %señal cuantizada con 2 bits
% hold on
% plot(data1)%señal original
% title("Señal 'musica 16 16' original vs cuantizada")
% ylabel("Amplitud");xlabel("muestras (n)");
% 
% %Gráficas para sonidos_voz_16_16
% subplot(2,1,2) 
% plot(y2)    %señal cuantizada con 2 bits
% hold on 
% plot(data2)  %señal original
% title("Señal 'sonidos voz 16 16'  original vs cuantizada")
% ylabel("Amplitud");xlabel("muestras (n)");


%% Parte 2b

N = 2^1;

[y,e] = cuantiza2(data1,N);
[y2,e2] = cuantiza2(data2,N);

subplot(2,1,1)
hist(e,20)
subplot(2,1,2)
hist(e2,20)

%% Parte 2c

%plot(l,r)
bits = [1 2 4 8 12];
while(1)
for i = 1:5
    N = bits(i);
    
    [y,e] = cuantiza2(data1,N);
    [re,le] = xcorr(e,200, 'unbiased');
    [r,l] = xcorr(e,y,200, 'unbiased');
    plot(l,r)
    hold on
    plot(le,re)
    pause(2)
    close
    
end
end




%% funciones cuantiza
function cuant = cuantiza(x,N)
   D = (max(x)- min(x))/(N-1);
   cuant = round((x-min(x))/D);
end

function [y,e] = cuantiza2(x,N)

   D = (max(x)- min(x))/(N-1);
   cuant = round((x-min(x))/D);
   
   y = cuant.*D + min(x);
   
   e = y-x; 
   
end



