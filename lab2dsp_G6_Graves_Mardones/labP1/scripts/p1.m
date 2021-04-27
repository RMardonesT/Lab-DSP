[besh, Fs] = audioread("besh.wav"); %6001 muestras

eps = besh(1300:3600);
sh = besh(4400:6001);


plot(besh, "b")
hold on
plot(eps, "r")

plot(sh, "black")


audiowrite("Lab2p1_vocal.wav", eps, Fs);
