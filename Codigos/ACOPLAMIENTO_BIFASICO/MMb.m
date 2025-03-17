function w = MMb(x,y)


N = length(x);

for i = 1:N
    if sign(x(i))==sign(y(i))
    % w(i) = 0.5*(sign(x(i))+sign(y(i)))*min(abs(x(i)),abs(y(i)));
    w(i) = sign(x(i))*min(abs(x(i)),abs(y(i)));
    else 
        w(i)=0;
    end
end
