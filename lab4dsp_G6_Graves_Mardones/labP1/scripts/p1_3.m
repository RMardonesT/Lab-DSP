clear all; clc;
N = [256,500,2048];
n = 0:1:500;
fs = 5000;

ws = 2*pi*fs

x1 = sin(2*pi*n/50);
x2 = cos(2*pi*n/50);



figure(1)

index_graph =1:7;

for i=1:length(N)
    ejex = [-ws/2:ws/N(i):ws/2-1];
    X1 = fftshift(fft(x1,N(i)));
    
   
    %Magnitud
    mag1 = abs(X1);
    
    %real
    rX1 = real(X1);
    
    %imag
    iX1 = imag(X1);
    

    if i==1
       
        subplot(3,3,i);
        plot(ejex,mag1);
        title("Magnitud de FFT de x1 con N =" + num2str(N(i))+ " entre [-\pi,\pi]")
        ylim([-50,200])
    
        subplot(3,3,i+1);
        plot(ejex,rX1);
        title("Parte Real  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])

        subplot(3,3,i+2);
        plot(ejex,iX1)
        title("Parte Imaginaria  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
        

    end
    
    if i== 2
        subplot(3,3,i*2);
        plot(ejex,mag1);
        title("Magnitud de FFT de x1 con N =" + num2str(N(i))+ " entre [-\pi,\pi]")
        ylim([-50,200])
        
        subplot(3,3, i*2+1);
        plot(ejex,rX1);
        title("Parte Real  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
        
        subplot(3,3,i*2+2);
        plot(ejex,iX1)
        title("Parte Imaginaria  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
   
    end
   
   if i== 3
        subplot(3,3,i*3-2);
        plot(ejex,mag1);
        title("Magnitud de FFT de x1 con N =" + num2str(N(i))+ " entre [-\pi,\pi]")
        ylim([-50,200])
        
        subplot(3,3,i*3-1);
        plot(ejex,rX1);
        title("Parte Real  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])

        subplot(3,3,i*3);
        plot(ejex,iX1)
        title("Parte Imaginaria  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
     
    end
    
    
end

figure(2)
%%
for i=1:length(N)
    ejex = [-ws/2:ws/N(i):ws/2-1];
 
    X2 = fftshift(fft(x2,N(i)));
       
    %Magnitud
    mag2 = abs(X2);
    
    %real
    rX2 = real(X2);
    
    %imag
    iX2 = imag(X2);
    
        if i==1
       
        subplot(3,3,i);
        plot(ejex,mag2);
        title("Magnitud de FFT de x1 con N =" + num2str(N(i))+ " entre [-\pi,\pi]")
        ylim([-50,200])
    
        subplot(3,3,i+1);
        plot(ejex,rX2);
        title("Parte Real  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])

        subplot(3,3,i+2);
        plot(ejex,iX2)
        title("Parte Imaginaria  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
        

    end
    
    if i== 2
        subplot(3,3,i*2);
        plot(ejex,mag2);
        title("Magnitud de FFT de x1 con N =" + num2str(N(i))+ " entre [-\pi,\pi]")
        ylim([-50,200])
    
        subplot(3,3, i*2+1);
        plot(ejex,rX2);
        title("Parte Real  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])

        subplot(3,3,i*2+2);
        plot(ejex,iX2)
        title("Parte Imaginaria  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
   
    end
   
   if i== 3
        subplot(3,3,i*3-2);
        plot(ejex,mag2);
        title("Magnitud de FFT de x1 con N =" + num2str(N(i))+ " entre [-\pi,\pi]")
        ylim([-50,200])
    
        subplot(3,3,i*3-1);
        plot(ejex,rX2);
        title("Parte Real  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])

        subplot(3,3,i*3);
        plot(ejex,iX2)
        title("Parte Imaginaria  FFT de x1 con N =" + num2str(N(i))+ " entre [\pi,\pi]")
        ylim([-50,200])
        
    end
    
end