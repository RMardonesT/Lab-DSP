function Y = decima(X,Q)
    %Filtrado
    B = fir1(40, 1/Q);
    y = filter(B,1,X);        
    
    %Downsampling
    N = round(length(X)/Q);
    Y = zeros(N,1);
    for i = 1:N
         Y(i)= y((i-1)*Q+1);
    end
    
    %Corrección de Magnitud    
    Y = Q*Y;
end