function n_ms = cruces_zero(x,fs)
    n = 0;
    
    for i = 1:length(x)-1
        if x(i+1)*x(i) < 0
            n = n+1;
        end
    end
    
    ms = 1000*length(x)/fs;
    n_ms = n/ms;    
end