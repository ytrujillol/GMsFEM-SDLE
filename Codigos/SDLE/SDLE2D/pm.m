function xm = pm(x)
n = length(x);
I = 2:n;
xm(I-1) = (x(I) + x(I-1))/2;