clear all; 
n  = 0:8-1;
N = length(n);

% Delta
x1 = double(kroneckerDelta(sym(n),0));
x2 = ones(1,N);
x3 = exp(-j*2*pi*n/N);
x4 = cos(2*pi*n/N);


x = [x1;x2;x3;x4];
sennales = ["x[n] = \delta [n]", "x[n] = 1", "x[n] = e^{\frac{-j2pin}{N}}", "x[n] = cos(2pi~n/N)"];

w = 2*pi*(-N/2:N/2-1)/N;

X1 =abs(DFTsum(x1));
X1fft = abs(fft(x1));

X2 =abs(DFTsum(x2));
X2fft = abs(fft(x2));

X3 =abs(DFTsum(x3));
X3fft = abs(fft(x3));

X4 =abs(DFTsum(x4));
X4fft = abs(fft(x4));


subplot(4,3,1)
stem(n,x1)
title("x1")

subplot(4,3,2)
stem(w,fftshift(X1))
title("DFTsum x1")

subplot(4,3,3)
stem(w,fftshift(X1fft))
title("FFt x1")

%x2
subplot(4,3,4)
stem(n,x2)
title("x2")

subplot(4,3,5)
stem(w,fftshift(X2))
title("DFTsum x2")

subplot(4,3,6)
stem(w,fftshift(X2fft))
title("FFt x2")

%x3

subplot(4,3,7)
stem(n,x3)
title("x3")

subplot(4,3,8)
stem(w,fftshift(X3))
title("DFTsum x3")

subplot(4,3,9)
stem(w,fftshift(X3fft))
title("FFt x3")

%x4

subplot(4,3,10)
stem(n,x4)
title("x4")

subplot(4,3,11)
stem(w,fftshift(X4))
title("DFTsum x4")

subplot(4,3,12)
stem(w,fftshift(X4fft))
title("FFt x4")


%% 

