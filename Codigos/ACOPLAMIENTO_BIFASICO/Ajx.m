function vx = vjx(u0,ordem,Nx,Ny)


% Nx = length(u0);
% Ny = length(u0);
  j = 1:Ny;
    i= 2:Nx-1;

       
  


% Dfp
A12(i,j) = u0(i+1,j) - u0(i,j);
A12(1,j) =A12(2,j);%u0(2,j)   - u0(1,j);
A12(Nx,j) = A12(Nx-1,j);% u0(Nx-1,j);

    
% Dfm
B12(i,j) = u0(i,j) - u0(i-1,j);
B12(1,j) =B12(2,j);% u0(1,j);
B12(Nx,j) =u0(Nx,j) -u0(Nx-1,j);


   switch ordem
    
    case 1
      %Derivadas minmod ordem 1
      vx(i,j) = MM(A12(i,j),B12(i,j));
      vx(1,j) = MM(A12(1,j),B12(1,j));
      vx(Nx,j)= MM(A12(Nx,j),B12(Nx,j));

      
    case 2
       a =1.45;%input('Entre o valor de alpha: ');
      % Derivada centrada
       C2(i,j) =u0(i+1,j)  -u0(i-1,j);
       C2(1,j) =C2(2,j)   ;
       C2(Nx,j) =  C2(Nx-1,j);%u0(Nx-1,j);
      
%        % minmod3
   
 vx(i,j) = MM3(a*A12(i,j),0.5*C2(i,j),a*B12(i,j));
 vx(1,j) = MM3(a*A12(1,j),0.5*C2(1,j),a*B12(1,j));
 vx(Nx,j)= MM3(a*A12(Nx,j),0.5*C2(Nx,j),a*B12(Nx,j));

   end   
