%% Overdrive
clear all; clc;
[signal, Fs] = audioread("gtr-jazz.wav"); 
soundsc(signal1,Fs)

alpha = 0.2, beta = 0.05;
Gi = 1, G0 = 1;

signal2 = Gi*signal;

y2= zeros(length(signal),1);

%%
for i  = 1:length(signal)
    i
    if abs(signal2(i)) >= alpha
        
        y2(i) = beta*signal2(i) +  sign(signal2(i))*(1-beta)*alpha;
    else
        y2(i) = signal2(i);
    end
    
   y = G0*y2;
        
end

y


