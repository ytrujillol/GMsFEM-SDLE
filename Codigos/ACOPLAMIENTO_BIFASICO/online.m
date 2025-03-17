function [p]=online(K,mob1,Elements,Element_list,vertex_list,mesh_parameter,R0GMsFEM,free0G,x0dG,Nx,Ny,nx,ny,hx,hy,W,Boundary );
 
coefficient_values_aux=K.*mob1;

   coefficient_values=coefficient_values_aux(:);
   %clear K
   
   Elements=[Element_list,coefficient_values]; %Tem que atualiza

  
  [Afinegrid,bfinegrid]=Nmatrix2(Elements,vertex_list,mesh_parameter); % Atualiza
   % Corrigir o fluxo na entrada
    %j = 1:32;
 leftfluxes=ones(size(W(1,:)));
 bfinegridflux=fluxcorrection(Elements,vertex_list,mesh_parameter,Boundary,leftfluxes); % Atualiza
 bfinegrid=bfinegrid+bfinegridflux;

   
  % computaiton of GMsFEM coarse matrix and coarse load vector
% [R0GMsFEM,free0G,x0dG]=matrixR_GMsFEM(bfinegrid,neigh,Nx,Ny);
A0GMsFEM=R0GMsFEM'*Afinegrid*R0GMsFEM; %Tem que atualiza
b0G=R0GMsFEM'*bfinegrid-A0GMsFEM*x0dG; %Tem que atualiza

% compuation of GMsFEM approximation of the pressure
downz0G=compute_GMsFEMpressure(A0GMsFEM,b0G,R0GMsFEM,free0G,x0dG); %Tem que atualiza

 pelement=compute_pressure_at_elements(downz0G, Nx,Ny,nx,ny);

 p=pelement;

end