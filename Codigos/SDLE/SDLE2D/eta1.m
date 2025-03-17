function z=eta1(xm,ym)

N=length(xm);

for i=1:N
    for j=1:N  
        if  (xm(i).^2)+ (ym(j).^2)<0.5
            z(i,j)=1;
        else
            z(i,j)=0; 
        end
    end 
end      