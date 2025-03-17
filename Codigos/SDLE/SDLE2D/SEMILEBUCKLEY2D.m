function LE =SEMILEBUCKLEY2D(u0,hx,hy,Nx,Ny)

    b=5;
    v_jx = (2/hx)*Ajx(u0,2) ;
    v_jy = (2/hy)*Ajy(u0,2) ;
    
    J=1:Ny;     
    
    I=2:Nx-1;
    
    fgx(I,J) = flux1(u0(I,J)) ;
    fgx(1,J) = flux1(u0(1,J));  
    fgx(Nx,J)= flux1(u0(Nx,J));
    
    umx(I,J) =u0(I+1,J)-0.25*hx*(v_jx(I+1,J));
    umx(1,J) =umx(2,J); %u0(2,J)  -0.25*hx*(v_jx(2,J));
    umx(Nx,J)=umx(Nx-1,J);
    
    
    % A aproximação de u(xj+1/2)  menos no tempo t
    
    ummx(I,J) =u0(I,J) +0.25*hx*(v_jx(I,J));
    ummx(1,J) =u0(1,J) +0.25*hx*(v_jx(1,J));
    ummx(Nx,J)=u0(Nx,J)+0.25*hx*(v_jx(Nx,J));
    
    bx(I,J)=b*max(max(abs(fgx(I,J)+fgx(I+1,J))));
    bx(1,J)=bx(2,J);
    bx(Nx,J)=bx(Nx-1,J);
    
    Px(I,J)=0.25*(bx(I,J).*(ummx(I,J)  -umx(I,J))  + (fgx(I,J)+fgx(I+1,J)).*(ummx(I,J) +umx(I,J)) );
    Px(1,J)= Px(2,J);
    Px(Nx,J)= Px(Nx-1,J);
    
    Hx(I,J)=-(1/hx).*( Px(I,J)-Px(I-1,J));
    Hx(1,J)=0; %Hx(2,J);
    Hx(Nx,J)=0; 
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555
    
    I=1:Nx;
    J=2:Ny-1;
    %        %Para a direção de y
    
    
    fgy(I,J) = flux1(u0(I,J)).*(1-5*(1-u0(I,J)).^2 ); 
    fgy(I,1) = flux1(u0(I,1)).*(1-5*(1-u0(I,1)).^2 );  
    fgy(I,Ny)= flux1(u0(I,Ny)).*(1-5*(1-u0(I,Ny)).^2 );
    
    umy(I,J) =u0(I,J+1)-0.25*hy*(v_jy(I,J+1));
    umy(I,1) =u0(I,2)  -0.25*hy*(v_jy(I,2));
    umy(I,Ny)=umy(I,Ny-1);
    
    % A aproximação de u(xj+1/2)  menos no tempo t
    
    ummy(I,J) =u0(I,J) +0.25*hy*(v_jy(I,J));
    ummy(I,1) =u0(I,1) +0.25*hy*(v_jy(I,1));
    ummy(I,Ny)=u0(I,Ny)+0.25*hy*(v_jy(I,Ny));%
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
    
    
    
    
    by(I,J)=b*max(max(abs(fgy(I,J)+fgy(I,J+1))));
    by(I,1)=by(I,2);
    by(I,Ny)=by(I,Ny-1);
    
    Py(I,J)=0.25*(by(I,J).*(ummy(I,J)-umy(I,J)) + (fgy(I,J)+fgy(I,J+1)).*( ummy(I,J)+umy(I,J)) );
    Py(I,1)= Py(I,2); 
    Py(I,Ny)=Py(I,Ny-1);
    
    
    
    
    Hy(I,J) =-(1/hy).*( Py(I,J)-Py(I,J-1));
    Hy(I,1)=0; %Hy(I,2);
    Hy(I,Ny)=0; %-(1/hy).*( Py(I,Ny)-Py(I,Ny-1));
    %  
    
    
    
    
    
    LE =Hx +Hy;