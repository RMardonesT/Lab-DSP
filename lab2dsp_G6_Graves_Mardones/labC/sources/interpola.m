
function y = interpola(x,P)
    y = [];
    N = length(x);

    for i = 1:N
        y = horzcat(y, x(i), zeros(1,P-1));
    end

    B = fir1(40, 1/P);
    y = filter(B,1,y);
    
    y = P*y; %corrección de magnitud
end