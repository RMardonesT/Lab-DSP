clear all; clc;
fs = 16000;

fp = 2400; Wp = fp/fs;
fsp = 4000; Wps = fsp/fs;

Rp = 0.5;
Rs = 40;

[n1,w1] = buttord(Wp,Wps,Rp,Rs);  %Butterworth IIR

[n2,w2] = cheb1ord(Wp,Wps,Rp,Rs); %Chebyshev IIR

[n3,w3] = ellipord(Wp,Wps,Rp,Rs); %Elliptic IIR


%https://la.mathworks.com/help/signal/ref/firpmord.html
% Parks-McClellan

f = [fp fsp];
a  = [1 0];
dev = [(10^(Rp/20)-1)/(10^(Rp/20)+1)  10^(-Rs/20)];

[n4,fo,ao,w] = firpmord(f,a,dev,fs);  %%FIR

