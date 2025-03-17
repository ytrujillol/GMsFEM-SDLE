function y0 = escalon2(x0,t)

for j=1:length(x0)
    
    if x0(j)<= t/2
        y0(j)=1;
    elseif x0(j)>t/2
        y0(j)=0;
    end
end