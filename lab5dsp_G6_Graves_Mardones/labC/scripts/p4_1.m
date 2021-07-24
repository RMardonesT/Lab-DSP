load("vowels.mat")

[amp,w] = positiveSpectrum(vowel_u)


plot(w,mag2db(amp))
title("Espectro positivo de la vocal 'U'")
xlabel("Frecuencia rad/muestra"); ylabel("Magnitud dB")