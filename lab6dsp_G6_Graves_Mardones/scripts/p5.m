
%Coeficientes del filtro de orden 4
F = [0 221 1764 4410 6615 8820 22050]/22050;
%corrección para entrar en [-32768, 32768]
A_corr = [2.1 2 1.3 1 1 1.2 1.5]*0.8;


%obtencion de coeficientes
[b,a] = yulewalk(4,F,A_corr);

[h,w] = freqz(b,a);

%gráficas 
plot(F,A_corr)
hold on 
plot(w/pi, abs(h))

title("Respuesta en frecuencia real vs obtenida")
xlabel("Frecuencia sps"); ylabel("Amplitud")
ylim([0.5,2])
grid on
legend(["Filtro ideal","Filtro aproximado"])


%obtención de coeficientes para los filtros
[sos, g] = tf2sos(b,a);

b1 = sos(1,1:3)
a1 = sos(1,4:6)

b2 = sos(2,1:3)
a2 = sos(2,4:6)













