
 function[p,Elements,Element_list,vertex_list,mesh_parameter,R0GMsFEM,free0G,x0dG,Nx,Ny,nx,ny]=offline2(ax,bx,ay,by,K);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ax =0;
%  bx =256;
% % 
% % 
%   ay =0;
%   by =64;


intx=[ax,bx];
inty=[ay,by];



% m1=8;
% Number of coarse blocks in the x and y direction
Nx=32; Ny=8;
% Number of fine-grid elements in each coarse block
nx=8; ny=nx;



additional_basis =0;


% mesh informaition
[Element_list, Boundary,vertex_list,mesh_parameter,h,boundary_nodes,free]=square_mesh(nx,ny,Nx,Ny,intx,inty);


%  addpath('C:\Users\jugal\Dropbox\Acoplamento\Permeabilidade-mobilidade')
% load permeabilidade.mat;

coefficient_values_aux=K;

coefficient_values=coefficient_values_aux(:);
  % clear K


Elements=[Element_list,coefficient_values]; %Tem que atualiza

% Stiffness and load vector in the fine mesh
[Afinegrid,bfinegrid]=Nmatrix(Elements,vertex_list,mesh_parameter); % Atualiza
% Mass matrix in the fine grid (if needed)

%Mfinegrid=NMassmatrix(Elements,vertex_list,mesh_parameter);
Xf=vertex_list(:,1);
Yf=vertex_list(:,1);
xdfinegrid=boundary_condition(Xf,Yf);%./P1;
bfinegrid2=bfinegrid-Afinegrid*xdfinegrid;
zfine=bfinegrid2*0;
zfine(free)=Afinegrid(free,free)\bfinegrid2(free);
zfine=zfine+xdfinegrid;

% Information realted to coarse grid neighborhoods
neigh=neighborhoods(ax,bx,ay,by,Nx,Ny,nx,ny);

% compuation of local eigenvalue problems Até aqui hiper
% of this coputation it is need to assamble local stiffness and mass matrix
% with neuman boundary condition in each neighboorhood
neigh=localeigenvectors(bfinegrid,neigh, Nx,Ny,additional_basis,Elements,vertex_list,mesh_parameter);
neigh=linearones(neigh,Nx,Ny,bfinegrid,vertex_list);

% computation of GMsFEM basis
neigh=GMsFEMbasis(neigh,Nx,Ny);

% computaiton of GMsFEM coarse matrix and coarse load vector
[R0GMsFEM,free0G,x0dG]=matrixR_GMsFEM(bfinegrid,neigh,Nx,Ny);
A0GMsFEM=R0GMsFEM'*Afinegrid*R0GMsFEM; %Tem que atualiza
b0G=R0GMsFEM'*bfinegrid-A0GMsFEM*x0dG; %Tem que atualiza

% compuation of GMsFEM approximation of the pressure
downz0G=compute_GMsFEMpressure(A0GMsFEM,b0G,R0GMsFEM,free0G,x0dG); %Tem que atualiza


% postprocessing of the preassure for elements
pelement1=compute_pressure_at_elements(downz0G, Nx,Ny,nx,ny);

%postproceesing the FINE SCALE SOLUTION
pelement=compute_pressure_at_elements(zfine, Nx,Ny,nx,ny);

p=reshape(pelement,Nx*nx,Ny*ny);


% surf( pelement')
%  shading interp;
%   colormap('jet') ;
% pbaspect([4 1 1])
% title("pressure")
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%