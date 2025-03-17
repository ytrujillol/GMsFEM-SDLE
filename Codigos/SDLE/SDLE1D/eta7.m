function z=eta7(x)
    N = length(x);
    for i = 1:N
        if x(i) >= 0 
            z(i)  = 1;
        else
            z(i) = -1;
        end
    end
return