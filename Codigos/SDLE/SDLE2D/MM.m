function w = MM(x,y)

    N = length(y);
    w = 0.5*(sign(x)+sign(y)).*min(abs(x),abs(y));