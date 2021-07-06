function y = exciteV(N,Np)
    
    y = zeros(1,N)
    
    for i = 1:N
        if mod(i-1,Np) == 0
            y(i) = 1;
    end
end