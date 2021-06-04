function y = IIR_filter( yBuff ,aCoeff,x)
    b0 = 1-0.99;
    y0 = b0*x - aCoeff.*yBuff;
    
    y = [y0 yBuff(1)];
end
