function vy = vjy(u0,ordem)

Nx = length(u0);
Ny = length(u0);
 
    i = 1:Nx;
    j = 2:Ny-1;
% Dfp
D12(i,j) = u0(i,j+1) - u0(i,j);
D12(i,1) = D12(i,2);% - u0(i,1);
D12(i,Ny) =D12(i,Ny-1);
        
%Dfm
D_12(i,j) = u0(i,j) - u0(i,j-1);
D_12(i,1) = u0(i,1) - u0(i,Nx);
D_12(i,Ny) = u0(i,Ny) - u0(i,Ny-1);
    



switch ordem
    
    case 1
         
      %Derivadas minmod ordem 1
      vy(i,j) = MM(D12(i,j),D_12(i,j));
      vy(i,1) =vy(i,2); % MM(D12(i,1),D_12(i,1));
      vy(i,Ny) =vy(i,Ny-1); % MM(D12(i,Ny),D_12(i,Ny));
      
    case 2
       a =1.;%input('Entre o valor de alpha: ');
       % Derivada centrada
       D_2(i,j) = u0(i,j+1)- u0(i,j-1);
       D_2(i,1) =D_2(i,2);
       D_2(i,Ny) =D_2(i,Ny-1);
       
       % minmod3
       vy(i,j) = MM3(a*D12(i,j),0.5*D_2(i,j),a*D_12(i,j));
       vy(i,1) = vy(i,2); % MM3(a*D12(i,1),0.5*D_2(i,1),a*D_12(i,1));
       vy(i,Ny)=  vy(i,Ny-1); %MM3(a*D12(i,Ny),0.5*D_2(i,Ny),a*D_12(i,Ny));
end    