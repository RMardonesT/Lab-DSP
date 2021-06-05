clear all; clc;

fp = 2400; wp =
fsp = 4000;
fs = 16000;
Rp = 0.5;
Rs = 40;

[n1,w1] = buttord(Wp,Ws,Rp,Rs);

[n2,w2] = cheb1ord(Wp,Ws,Rp,Rs)