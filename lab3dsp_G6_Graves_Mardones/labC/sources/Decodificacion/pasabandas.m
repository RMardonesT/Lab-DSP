clc; clear all;
format long



f0 = [697 770 852 941 1209 1336 1477];
fs = 16000;

B = zeros(7,3);  %%Polinomios del denominador para 697, 770, 941
A = zeros(7,3);  %%Polinomios del numerador para 697, 770, 941

Bw = 2*pi*60/fs;


for i =1:3
    
    theta = 2*pi*f0(i)/fs;
    [a,b] = BPF(Bw,theta);
    
    for k=1:3
       B(i,k) = b(k);
       A(i,k) = a(k);
    end

       
end



Bw = 2*pi*100/fs;

for i =4:7
    
    theta = 2*pi*f0(i)/fs;
    [a,b] = BPF(Bw,theta);
    
    for k=1:3
       B(i,k) = b(k);
       A(i,k) = a(k);
    end

       
end

%%
for i=1:7
    fprintf('F0 = %i\n' , f0(i))
    fprintf('B  \n')
    
    fprintf('b0 = %f , b1 = %f b2 = %f\n',  B(i,1), B(i,2), B(i,3))
    
    
    fprintf('A  \n')
    fprintf('a0 = %f , a1 = %f a2 = %f',  A(i,1), A(i,2), A(i,3))
    
        
    fprintf("\n\n")
end

for i = 1: length(f0)
    
    subplot(4,2,i)
    [h,w] = freqz(B(i,:), A(i,:));
    plot(w,20*log(abs(h)));
    grid on
    title("Filtro Pasa banda para " + num2str(f0(i)) + "Hz Normalizada según " + num2str(fs/1000)+ "kHz")
    

end
