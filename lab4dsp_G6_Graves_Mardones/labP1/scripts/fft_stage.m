function X = fft_stage(x)
    N = length(x);
    
    if (N == 2)
        X = FFT2(x);
        return
    else    
        x0    = zeros(1,N/2); x1    = zeros(1,N/2);        
    
        for i = 1:N/2
            x0(i) = x(2*i-1); %OBS "par"   1,3,5,... en MATLAB
            x1(i) = x(2*i);   %OBS "impar" 2,4,6,... en MATLAB       
        end
    
        W = exp(-1j*2*pi/N);  Wk = W.^(0:(N/2-1));        
        X0 = fft_stage(x0) ;  X1 = fft_stage(x1) ; 
    
        X_izq = X0 + Wk.*X1;
        X_der = X0 - Wk.*X1;
    
        X = [X_izq X_der];
    end
end