% Generacion curvas

% Tiempo entre muestras Ts=  0.01/10

Ts = 0.01/10;

t = [0:Ts:0.06]; % Genera vector temporal

% Periodo señal

T = 0.02;

f = 1/T;


%Generacion puntos

y = sin(2pif*t);


%Ploteo

plot(t,y, 'color', 'r')

hold on

stairs(t,y, 'color', 'b')

grid on

xlabel('Tiempo [s]')

ylabel('Amplitud')

xlim([0, 0.06])

ylim([-1, 1])