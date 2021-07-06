clear all;
load 'vowels';
%%

%se escoge a
chosen = vowel_a;

%definicion ordenes
p1=15;
p2=9;

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


%% repdoduccion
soundsc(sint_1,fs)
pause(2)
soundsc(sint_2,fs)

%% graficas 

figure(1)
subplot(3,1,1)
plot(w1,  20*log10(abs(CHOSEN)))

subplot(3,1,2)
plot(w2,  20*log10(abs(abs(SINT_1))))

subplot(3,1,3)
plot(w2,  20*log10(abs(abs(SINT_2))))

figure(2)
subplot(2,1,1)
zplane(1,a_p1);
subplot(2,1,2)
zplane(1,a_p2);


