function LG = SEMINLGRare(u0,h,N,k)
    I =2:N-1;
    Iv=2:N-1;                        
    v_j =(2/h)* vj(u0,2);
    
    um(I)=u0(I+1)-0.25*h*(v_j(I+1));
    um(1)=um(2);
    um(N)=um(N-1);
    
    umm(I)=u0(I)+0.25*h*(v_j(I));
    umm(1)=umm(2);
    umm(N)=umm(N-1);
    
    fg(I) = 0.5*(u0(I)); 
    fg(1) = 0.5*(u0(1));  
    fg(N) =0.5*(u0(N));
    
    c=1;
    
    b(I)=c*abs(max(fg(I+1)+fg(I)));
    b(1)=c*abs(max((fg(2)+fg(1))));
    b(N)=c*abs(max(fg(1)+fg(N)));
    
    F(I)=0.25*((b(I)).*(umm(I)-um(I)) + (fg(I)+fg(I+1)).*( umm(I)+um(I))     );
    F(1)=F(2);
    F(N)=F(N-1);
    
    LG(Iv)= -(1/h).*(F(Iv)-F(Iv-1));
    LG(1)=LG(2);
    LG(N)=LG(N-1);