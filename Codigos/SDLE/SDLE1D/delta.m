function delta = delta(u0,h,lcfl)
    m = length(u0);
    for j = 2:m-1
        c=0.5;
        F1(j)=max(c*abs(u0(j))) ; 
        F1(1)=max(c*abs(u0(1)));
        F1(m)=max(c*abs(u0(m)));
    end 
    FM = max(abs(F1));
    
    if FM == 0
        delta = 0.5*lcfl*h;
      else
        d = 0.5*lcfl*h./FM;
        delta =min(d);
    end   