clear all;
load 'vowels';
%%

%se escoge a
chosen = vowel_u;

%definicion ordenes
p1=15;
p2=10;

%excite
t =0.5;
f = 100;
T = fs/f;
X = exciteV(t*fs,T);

%coeficientes 
a_p1=lpc(chosen,p1);
a_p2=lpc(chosen,p2);

%sintetizacion
sint_1 = filter(1,a_p1,X);
sint_2 = filter(1,a_p2,X);

%frecuencias
w1 = linspace(0,pi,length(chosen));
w2 = linspace(0,pi,length(X));

%%fft

CHOSEN = fft(chosen);
SINT_1 = fft(sint_1);
SINT_2 = fft(sint_2);


% repdoduccion
soundsc(sint_1,fs)
pause(2)
soundsc(sint_2,fs)

%% graficas 

figure(1)
subplot(3,1,1)
plot(w1,  20*log10(abs(CHOSEN)))
title("Espectro de la señal original de la vocal 'A'")
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")

subplot(3,1,2)
plot(w2,  20*log10(abs(abs(SINT_1))))
title("Espectro de la señal filtrada con orden "+ num2str(p1))
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")

subplot(3,1,3)
plot(w2,  20*log10(abs(abs(SINT_2))))
title("Espectro de la señal filtrada con orden "+ num2str(p2))
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")

figure(2)
subplot(2,1,1)
zplane(1,a_p1);
subplot(2,1,2)
zplane(1,a_p2);

%%
[amp,w] = positiveSpectrum(vowel_u)
figure(1)
subplot(4,1,1)
plot(w,  20*log10(amp))
title("Espectro positivo de la vocal 'U'")
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")

subplot(4,1,2)
plot(w2,  20*log10(abs(abs(SINT_1))))
title("Espectro de la señal filtrada con orden "+ num2str(p1))
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")

subplot(4,1,3)
plot(w2,  20*log10(abs(abs(SINT_2))))
title("Espectro de la señal filtrada con orden "+ num2str(p2))
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")



%%
subplot(4,1,4)
plot(w2,  20*log10(abs(abs(SINT_2))))
title("Espectro de la señal filtrada con orden "+ num2str(p2))
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")
%%
figure(2)
subplot(2,1,1)
zplane(1,a_p1);
subplot(2,1,2)
zplane(1,a_p2);

%%  4_4



[sos,g] = tf2sos(1,a_p1)

figure

<<<<<<< Updated upstream
cell_array ={};
=======
%legend('Filtro Biquad 1','Filtro Biquad 2','Filtro Biquad 3','Filtro Biquad 4','Filtro Biquad 5','Filtro Biquad 6','Filtro Biquad 7');

hold on
title("Magnitud de filtros biquad que sintetizan la vocal 'A'")
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud")


>>>>>>> Stashed changes
for i=1:length(sos)
    cell_array = {cell_array, "Respuesta en frecuencia del filtro biquad número " + num2str(i)};

    biquad = sos(i,:);

    a = biquad(1:3);
    b = biquad(4:6);
    
<<<<<<< Updated upstream
    plot(w,h)
=======
    [h,w] = freqz(a,b);
    
    plot(w,mag2db(abs(h)))
    hold on
    legend('Filtro Biquad 1','Filtro Biquad 2','Filtro Biquad 3','Filtro Biquad 4','Filtro Biquad 5','Filtro Biquad 6','Filtro Biquad 7','Filtro Biquad 8');
end


>>>>>>> Stashed changes

%%

[amp,w] = positiveSpectrum(vowel_a)
plot(w,mag2db(amp), "c")
hold on
title("Magnitud de filtros biquad que sintetizan la vocal 'A'")
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud")


for i=1:length(sos)

    biquad = sos(i,:);

    a = biquad(1:3);
    b = biquad(4:6);
    
    [h,w] = freqz(a,b);
    
    plot(w,mag2db(abs(h)))
    hold on
    legend('Filtro Biquad 1','Filtro Biquad 2','Filtro Biquad 3','Filtro Biquad 4','Filtro Biquad 5','Filtro Biquad 6','Filtro Biquad 7','Filtro Biquad 8');
end
legend(cell_array)



