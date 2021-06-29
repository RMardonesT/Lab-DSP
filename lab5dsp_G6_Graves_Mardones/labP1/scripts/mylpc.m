function y = mylpc(x,p)
    rx = xcorr(x);    
    rx_toeplitz  = rx(length(x):length(x)+p-1);
    rx = rx(length(x)+1:length(x)+p);

    Ra = toeplitz(rx_toeplitz);

    a = (Ra\rx)';
    y = [1 -a];
end