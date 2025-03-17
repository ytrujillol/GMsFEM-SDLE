function delta = delta(u0,hx,hy,lcfl)

    Nx = length(u0);
    Ny = length(u0);
    
    v_jx =(0/hx)*Ajx(u0,2);
    v_jy =(0/hy)*Ajy(u0,2);
    
    j = 1:Ny;
    i = 2:Nx-1;
    
    z=1;
    
    F1x(i,j) = flux1(u0(i,j)) ;
    F1x(1,j) = flux1(u0(1,j));  
    F1x(Nx,j)= flux1(u0(Nx,j));
    
    i = 1:Nx;
    j = 2:Ny-1;
    
    F1y(i,j) = flux1(u0(i,j)).*(1-5*(1-u0(i,j)).^2 ); 
    F1y(i,1) = flux1(u0(i,1)).*(1-5*(1-u0(i,1)).^2 );  
    F1y(i,Ny)= flux1(u0(i,Ny)).*(1-5*(1-u0(i,Ny)).^2 );
    
    FMx = max(abs(F1x));
    
    FMy = max(abs(F1y));
    
    if FMy == 0
        delta =0.5*lcfl* max(hx,hy);
    else
        d = 0.5*lcfl*max(  (hx/max(abs(FMx))), ((hy/max(abs(FMy))))  );
        delta =min (d);
    end