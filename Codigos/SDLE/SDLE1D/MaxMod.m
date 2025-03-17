function w = MaxMod(x,y)


N = length(y);

for i = 1:N
    if sign(x(i))==sign(y(i))
    w(i) = sign(x(i))*max(abs(x(i)),abs(y(i)));
    else 
        w(i)=0;
    end
end