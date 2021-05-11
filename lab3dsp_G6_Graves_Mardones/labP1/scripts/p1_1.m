clear all; clc;

dt= 0.1;
t =-1:dt:1-dt;
L=length(t);

%% Generación del impulso

delta=dirac(t);
Dx = delta ==inf;
delta(Dx) = 1;
%% filtro  y[n] = x[n] -2cos(theta)x[n-1] + x[n-2]

impulso_rec = zeros(1,L);


theta = [pi/6,pi/3, pi/2];


for  i=1:1:3
    figure(i)
    angle = theta(i);
    for n=3:1:L
        impulso_rec(n)= delta(n) - 2*cos(angle)*delta(n-1) + delta(n-2);
    end
    
    num = [1 -2*cos(angle) 1];
    den = [1 0 0];
    impulso_filt = filter(num,den,delta)
    
    stem(impulso_rec)
    hold on
    plot(impulso_filt)
       
end

%%
plot(impulso_filt)
