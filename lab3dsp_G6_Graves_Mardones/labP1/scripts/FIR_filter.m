function y_conv = FIR_filter(x,theta)
    %Parametros del filtro
    filt = [1 -2*cos(theta) 1, zeros(1,100)];
    y_conv = conv(x,filt);
end 