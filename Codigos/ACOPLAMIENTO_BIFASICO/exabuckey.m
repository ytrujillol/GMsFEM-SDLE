 function y = exabuckey(x,t)

syms a
g(a)=finverse(a*(1-a)./(a.^2+0.5*(1-a).^2).^2   );
for j=1:length(x)
    
    if x(j)<=0
        y(j)=1;
    elseif x(j)>0 && x(j)<=1.3660*t
        y(j)=g(x(j)/t);
    elseif x(j)>1.3660*t && x(j)<0.57*t;
        y(j)=1.3660;
    else x(j)>0.57*t
        y(j)=0;
    end
end

    end
