function xm = pmb(x)


n = length(x);
I = 2:n;
    xm(I-1) = (x(I) + x(I-1))/2;
    %xm(1) = x(1);
    
%xm(1)=0;
%xm(1) = a - x(2);
%xm(n) = xm(j) +  (xm(n-1) - x(n-2))/2;
