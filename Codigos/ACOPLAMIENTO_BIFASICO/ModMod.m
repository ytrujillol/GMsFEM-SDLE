function MM=ModMod(x)
numero=length(x);
a=0;
b=0;
c=0;
for j=1:numero
    if x(j)>=0
        a=a+1;
    elseif x(j)<=0
        b=b+1;
    else
        c=c+1;
    end
end

if a==numero;
    MM=min(x);
elseif b==numero;
    MM=max(x);
else
    MM=0;
end