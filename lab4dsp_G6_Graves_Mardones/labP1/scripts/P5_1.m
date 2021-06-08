clc;


N = [2,4,8];

for i = 1:length(N)
    a = dftmtx(N(i));
    A = genAmatrix(N(i));

    err = immse(a,A)
end
