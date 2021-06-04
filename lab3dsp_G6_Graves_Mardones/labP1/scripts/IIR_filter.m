function nextyBuff = IIR_filter(yBuff, aCoeff, x)
    a1 = aCoeff(1);
    a2 = aCoeff(2);
    
    %Filtrado por ecuación de diferencias
    output = (a1*yBuff(1) + a2*yBuff(2) + x);
    
    %Actualización del Buffer para siguiente señal de entrada
    yBuff(2) = yBuff(1);
    yBuff(1) = output;
    
    nextyBuff = yBuff;   
end