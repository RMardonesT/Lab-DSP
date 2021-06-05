clear all; clc;
fs = 16000;

fp = 2400; Wp = fp/fs;
fsp = 4000; Wps = fsp/fs;

Rp = 0.5;
Rs = 40;

[n1,w1] = buttord(Wp,Wps,Rp,Rs);

[n2,w2] = cheb1ord(Wp,Wps,Rp,Rs);

[n3,w3] = ellipord(Wp,Wps,Rp,Rs);

