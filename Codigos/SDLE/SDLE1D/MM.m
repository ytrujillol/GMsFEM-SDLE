function w = MM(x,y)


N = length(x);

for i = 1:N
    if sign(x(i))==sign(y(i))
    w(i) = sign(x(i))*min(abs(x(i)),abs(y(i)));
    else 
        w(i)=0;
    end
end
