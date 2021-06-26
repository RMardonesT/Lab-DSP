%% 7_1
[x, Fs] = audioread('dtmfSequence_16_16.wav');

N = 256;
x = x(1:N)

X = fft(x);
Xmod = abs(X);

stem(0:29, Xmod(1:30))

%%  7_2

clc;
str_bins = ["11","12","14","15","19","21","24"];


for i = 1:length(str_bins)
    subplot(length(str_bins),1,i)
    
    
    if (i<5)
        bar(out.bins(:,i))
        
    else
        bar(out.bins(:,1),"r")
    end
    
    ylabel("Bin " +  str_bins(i))
        
end

sgtitle("Bins para frecuencias DTMF con algoritmo Goertzerl")

