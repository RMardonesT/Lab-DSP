f0 = [697 770 852 941 1209 1336 1477];
fs = 16000;
deltaBw = 20;
Bw = 2*pi*deltaBw/fs;
d = 1 - sqrt(1-cos(Bw)^2);
d = d/cos(Bw);
theta = 2*pi*f0/fs;

B = zeros(3,length(f0));
A = zeros(3,length(f0));


for i = 1: length(f0)
    B(1,i) = (1-d)/2;
    B(2,i) = 0;
    B(3,i) =  B(1,i);
    
    A(1,i) = -(1+d)*cos(theta(i));
    A(2,i) = d;
    
    subplot(4,2,i)
    [h,w] = freqz(B(:,i),[1; A(:,i)]);
    plot(w,20*log(abs(h)))
    grid on
    title(num2str(f0(i)))
    

end
