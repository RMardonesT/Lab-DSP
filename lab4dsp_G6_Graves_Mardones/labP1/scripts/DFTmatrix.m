function X = DFTmatrix(x)
    N = length(x);
    A = genAmatrix(N);
    X = sum(A'.*x');
end
