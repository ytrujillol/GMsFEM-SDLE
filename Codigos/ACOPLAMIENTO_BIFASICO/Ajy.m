function vy = vjy(u0,ordem,Nx,Ny)


% clear all
% clc
% clf
% mx=4;
% my=4;
% x=linspace(0,1,mx+1);
% y=linspace(0,1,my+1);
% 
% xm=pm(x);
% ym=pm(y);
% [xmed,ymed]=meshgrid(xm,ym);
% u0=eta(xm,ym)
% Nx = length(u0);
% Ny = length(u0);
 
    i = 1:Nx;
    j = 2:Ny-1;
% Dfp
D12(i,j) = u0(i,j+1) - u0(i,j);
D12(i,1) = u0(i,2) - u0(i,1);
D12(i,Ny) =D12(i,Ny-1);
        
%Dfm
D_12(i,j) = u0(i,j) - u0(i,j-1);
D_12(i,1) =D_12(i,2);% u0(i,1) - u0(i,N);
D_12(i,Ny) = u0(i,Ny) - u0(i,Ny-1);
    



switch ordem
    
    case 1
         
      %Derivadas minmod ordem 1
      vy(i,j) = MM(D12(i,j),D_12(i,j));
      vy(i,1) = MM(D12(i,1),D_12(i,1));
      vy(i,Ny) = MM(D12(i,Ny),D_12(i,Ny));
      
    case 2
       a =1.45;%input('Entre o valor de alpha: ');
       % Derivada centrada
       D_2(i,j) = u0(i,j+1)- u0(i,j-1);
       D_2(i,1) =D_2(i,2);
       D_2(i,Ny) =D_2(i,Ny-1);
       
       % minmod3
       vy(i,j) = MM3(a*D12(i,j),0.5*D_2(i,j),a*D_12(i,j));
       vy(i,1) = MM3(a*D12(i,1),0.5*D_2(i,1),a*D_12(i,1));
       vy(i,Ny)= MM3(a*D12(i,Ny),0.5*D_2(i,Ny),a*D_12(i,Ny));
 end
   
   
%     case 3
%         
%         % Derivada de segunda ordem j
%         D_2j(I,J) = u0(I,J-1)-2*u0(I,J)  +u0(I,J+1);
%         D_2j(I,1) = u0(I,N)  -2*u0(I,1)  +u0(I,2);
%         D_2j(I,N) = u0(I,N-1)-2*u0(I,N)  +u0(I,1);
%         
%         % Derivada de segunda ordem j-1
%         D_2j_1(I,J) = D_2j(I,J-1);
%         D_2j_1(I,N) = D_2j(I,N-1);
%         D_2j_1(I,1) = D_2j(I,N);
%         
%         % Derivada de segunda ordem j+1
%         D_2jp1(I,J) = D_2j(I,J+1);
%         D_2jp1(I,1) = D_2j(I,2);
%         D_2jp1(I,N) = D_2j(I,1);        
%         
%         % minmod
%         vy = MM(D_12+0.5*MM(D_2j_1,D_2j),D12-0.5*MM(D_2j,D_2jp1));
%         
%          case 4
%         v1=MM(D12,2*D_12);
%         v2=MM(2*D12,D_12);
%        v=MaxMod(v1,v2);
%         
% end
% end
% 
     