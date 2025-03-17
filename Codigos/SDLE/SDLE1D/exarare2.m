function y0 = exarare2(x0,t)

for j=1:length(x0)
    
    if x0(j)<=-t
        y0(j)=-1;
    elseif x0(j)>-t && x0(j)<=t
        y0(j)=x0(j)/t;
    else x0(j)>t;
        y0(j)=1;
    end
end