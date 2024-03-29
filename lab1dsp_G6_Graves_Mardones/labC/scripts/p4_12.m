%% definiciones
clear all
load('aliasing_test_16_16.mat', 'aliasing_test'); %aliasing_test  definition
load('aliasing_test_16_16.mat', 'Fs'); %Fs definition

soundsc(aliasing_test,Fs);

n = length(aliasing_test);
n2 = round(n/2);
n3 = round(n/3);

%% Downsompling con D = 2
aliasing_2n = zeros( n2,1);

for i = 2:2:n
    aliasing_2n(i/2) = aliasing_test(i);
    
end

soundsc(aliasing_2n, Fs/2);


%% Downsompling con D = 3

aliasing_3n = zeros( n3,1);

for i = 3:3:n
    aliasing_3n(i/3) = aliasing_test(i);
    
end

soundsc(aliasing_3n, Fs/3);


%subplot(3,1,1)

spectrogram(aliasing_test, 256, [], [], Fs, 'yaxis')
% title("aliasing-test-16-16.mat original")
% 
% subplot(3,1,2)
% spectrogram(aliasing_2n, 256, [], [], Fs, 'yaxis')
% title("aliasing-test-16-16.mat cada 2n muestras")
% 
% subplot(3,1,3)
% spectrogram(aliasing_3n, 256, [], [], Fs, 'yaxis')
% title("aliasing-test-16-16.mat 1 de cada 3 muestras")

