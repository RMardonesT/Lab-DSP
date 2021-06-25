%%%%% Parte VI Lab 4 DSP

%%% 3. Comparación fft_stage con fft

num = 10:19;

Fs = 5000;

t2 = zeros(1,10);
t1 = zeros(1,10);
abserr = zeros(1,10);

for ctr = 1:10
    N = 2.^num(ctr);
    t = (0:N-1)/Fs;
    
    x = cos(2*pi*100*t); % Señal a analizar
    
    f1 = @() fft(x);
    f2 = @() fft_stage(x);
    
    t1(ctr) = timeit(f1);
    t2(ctr) = timeit(f2);
    
    abserr(ctr) = max(abs(fft(x)-fft_stage(x)));
end
    
figure
plot(num, t1)
hold on
plot(num, t2)
xlabel("Muestras en escala logarítmica base 2 [-]"); ylabel("tiempo [s]")
title("Comparacion de costo computacional entre fft y fft\_stage")
legend("fft","fft_stage")

figure
plot(num, abserr)
xlabel("Muestras en escala logarítmica base 2 [-]");
ylabel("Máximo error absoluto [-]")
title("Máximo error absoluto entre fft y fft\_stage para señal de prueba")