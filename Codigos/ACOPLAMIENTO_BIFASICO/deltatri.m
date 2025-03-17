%function delta = del_t(u0,h_0,cfl) caso h_0 vetor de tamano de passo
function delta = deltatri(W,h,lcfl,Nx1,Ny1,ux,uy)





   
    
%   
%     for j = 1:Ny
%        for i = 1:Nx 

      
%        if abs(W(i,j)) > 0 
      
%         
           % F1(i,j) = fluxW(W(i,j));
            % F1(i,j) = fluxW(W(i,j));
            F1= ux.*fluxW(W);
            F2= uy.*fluxW(W);

%         
%         
            
%         
%        end
      
%        end
%     end
     
     FH = max( max( abs(F1),abs(F2) )  );
    
    
      if FH == 0
         deltaH = (1/4)*lcfl*h;
       else
         deltaH = ((1/4)*h*lcfl)./FH;
         %delta = min(deltaH);
     
      end
     
   
     
     delta = min(deltaH);
   

