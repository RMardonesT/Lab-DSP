function nextyBuff = IIR_filter(yBuff, aCoeff, x)
    a0 = a(Coeff1);
    a1 = aCoeff(2);
    a2 = aCoeff(3);
    
    %Filtrado por ecuación de diferencias
    output = a1*yBuff(1) + a2*yBuff(2) + x;
    
    %Actualización del Buffer para siguiente señal de entrada
    yBuff(2) = yBuff(1);
    yBuff(1) = output;
    
    nextyBuff = yBuff;   
end