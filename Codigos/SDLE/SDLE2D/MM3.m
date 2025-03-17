function w = MM3(x,y,z)
    N = length(y);
    w = MM(x,MM(y,z));