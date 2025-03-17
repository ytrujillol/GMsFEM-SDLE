function LEW = SEMIBIW5(W,hx,hy,Nx,Ny,ux,uy);

% W: water

%M: 1-W

b=15; %3;
  

WL=1;

ux(:,1)=0;  
% % %ux(Nx,:)=0; 
 ux(:,Ny)=0;


 uy(:,1)=0;  
%ux(Nx,:)=0; 
uy(:,Ny)=0;
 
 
 
fWx=ux.*fluxW(W);
fWy=uy.*fluxW(W);

 


 
     J=1:Ny;     
     
      I=2:Nx-1;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
        W_jx = (2/hx)*Ajx(W,2,Nx,Ny) ;
        W_jy = (2/hy)*Ajy(W,2,Nx,Ny) ;

        %  O MInmod                         
%         W_j =(1/h)* vj(W,2);
%         G_j =(1/h)* vj(G,2);

     
 % FOR THE WATER w 
       Wmx(I,J)  =W(I+1,J)-0.25*hx*(W_jx(I+1,J));
       Wmx(1,J)  =W(2,J)-0.25*hx*(W_jx(2,J));%ones(size(Wmx(1,:)));%
       Wmx(Nx,J) =Wmx(Nx-1,J); 
       
       
       % A aproximação de u(xj+1/2)  menos no tempo t
       
       Wmmx(I,J) =W(I,J) +0.25*hx*(W_jx(I,J));
       Wmmx(1,J) =WL*ones(size(Wmmx(1,:)));%; %W(1,J) +0.25*hx*(W_jx(1,J));
       Wmmx(Nx,J)=(W(Nx,J)+0.25*hx*(W_jx(Nx,J)));
       
  
  
  
   
  
   
   bWx(I,J)=b*max(max(abs( fWx(I,J)+fWx(I+1,J)  )));
   bWx(1,J)=b*max(max(abs( fWx(1,J)+fWx(2,J)  )));
   bWx(Nx,J)=bWx(Nx-1,J);

%    
%  
 % NUMERICAL FLUX FOR H      
          
  %%% LE Lagrangian-Eulerian  with reconstruction% Outra forma
   FWx(I,J)=0.25*(bWx(I,J).*(Wmmx(I,J)-Wmx(I,J)) + (fWx(I,J)+fWx(I+1,J)).*( Wmmx(I,J)+Wmx(I,J))     );
   FWx(1,J)=0.25*(bWx(1,J).*(Wmmx(1,J)-Wmx(1,J)) + (fWx(1,J)+fWx(2,J)).*( Wmmx(1,J)+Wmx(1,J))); 
   FWx(Nx,J)=0.25*(bWx(Nx,J).*(Wmmx(Nx,J)-Wmx(Nx,J)) + (fWx(Nx,J)+0*fWx(2,J)).*( Wmmx(Nx,J)+Wmx(Nx,J))); 
     
    


% NUMERICAL FLUX FOR WATER   
Hwx(I,J) = -(1/hx).*(FWx(I,J)-FWx(I-1,J));
Hwx(1,J) =-(1/hx).*(FWx(1,J)-0*FWx(Nx,J)   ); 
Hwx(Nx,J)=-(1/hx).*(FWx(Nx,J)-FWx(Nx-1,J)); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I=1:Nx;
         J=2:Ny-1;
      
         
   % FOR THE WATER w 
   Wmy(I,J) =W(I,J+1)-0.25*hy*(W_jy(I,J+1));
   Wmy(I,1) =(W(I,2)-0.25*hy*(W_jy(I,2))); 
   Wmy(I,Ny)=Wmy(I,Ny-1);%(W(I,Ny)-0.25*hy*(W_jy(I,Ny)));  

   % A aproximação de u(xj+1/2)  menos no tempo t

   Wmmy(I,J) =W(I,J)+0.25*hy*(W_jy(I,J));
   Wmmy(I,1) =((W(I,1)+0.25*hy*(W_jy(I,1))));
   Wmmy(I,Ny)=(W(I,Ny)+0.25*hy*(W_jy(I,Ny)));

 
  
 
   
bWy(I,J) =b*max(max(abs( fWy(I,J)+fWy(I,J+1)  )));
bWy(I,1) =b*max(max(abs( fWy(I,1)+fWy(I,2)  ))); %não precisa mudar
bWy(I,Ny)=bWy(I,Ny-1);

%    
%  
 % NUMERICAL FLUX FOR H      
          
  %%% LE Lagrangian-Eulerian  with reconstruction% Outra forma
FWy(I,J) =0.25*(bWy(I,J).*(Wmmy(I,J)-Wmy(I,J)) + (fWy(I,J)+fWy(I,J+1)).*( Wmmy(I,J)+Wmy(I,J))     );
FWy(I,1) =0.25*(bWy(I,1).*(Wmmy(I,1)-Wmy(I,1)) + (fWy(I,1)+fWy(I,2)).*( Wmmy(I,1)+Wmy(I,1))   );
FWy(I,Ny)=0.25*(bWy(I,Ny).*(Wmmy(I,Ny)-Wmy(I,Ny)) + (fWy(I,Ny)+0*fWy(I,2)).*( Wmmy(I,Ny)+Wmy(I,Ny)) );
     
    


% NUMERICAL FLUX FOR WATER   
Hwy(I,J)= -(1/hy).*(FWy(I,J)-FWy(I,J-1));
Hwy(I,1)= -(1/hy).*(FWy(I,1)-0*FWy(I,Ny));                         %não precisa mudar
Hwy(I,Ny)=-(1/hy).*(FWy(I,Ny)-FWy(I,Ny-1));%  
        
        
LEW =Hwx+Hwy;
