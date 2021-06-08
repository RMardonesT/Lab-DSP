function X = DFTsum(x)
    N = length(x);
    X = zeros(1,N);
    for k = 0:N-1
        coef = exp(-1j*2*pi*k/N);
        for n = 0:N-1
            X(1,k+1) = X(1,k+1) + x(n+1)*coef^n;
          
        end
        
    end
    
end