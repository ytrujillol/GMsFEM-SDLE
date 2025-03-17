%      function [pelement,coefficient_values_aux] = testcode(ax,bx,ay,by);

%      function [pelement] = testcode(ax,bx,ay,by,K);


% The doman is [0,1]x[0,1]. keep this domain.
 ax=0;bx=256; ay=0;by=64;
 


intx=[ax,bx];
inty=[ay,by];

m1=8;
% Number of coarse blocks in the x and y direction
Nx=16;  Ny=4;
% Number of fine-grid elements in each coarse block
nx=8; ny=nx;


%number of additional basis functions for all coarse nodes neighborhoods
% these are on top of need basis fucntions according to spectral gap
% In total it used additional_basis+spectral_gap_basis
additional_basis =5;




% mesh informaition
[Element_list, Boundary,vertex_list,mesh_parameter,h,boundary_nodes,free]=square_mesh(nx,ny,Nx,Ny,intx,inty);

% coefficient (it is a vector with the coefficient values in each element).
% coefficient value is added to the triangulation information, 
 %addpath('C:\Users\user\Downloads\Acoplamentojeanjuan\Permeabilidade-mobilidade')

 addpath('C:\Users\jugal\Dropbox\Acoplamento\Permeabilidade-mobilidade')
load permeabilidade.mat;
%[nR,nC]=size(K);
%K(1:80,:)=1;
coefficient_values_aux=K(1:64,1:64);

coefficient_values=coefficient_values_aux(:);
clear K


Elements=[Element_list,coefficient_values]; %Tem que atualiza

% Stiffness and load vector in the fine mesh
[Afinegrid,bfinegrid]=Nmatrix(Elements,vertex_list,mesh_parameter); % Atualiza
% Mass matrix in the fine grid (if needed)
%Mfinegrid=NMassmatrix(Elements,vertex_list,mesh_parameter);

% Information realted to coarse grid neighborhoods
neigh=neighborhoods(ax,bx,ay,by,Nx,Ny,nx,ny);

% compuation of local eigenvalue problems Até aqui hiper
% of this coputation it is need to assamble local stiffness and mass matrix
% with neuman boundary condition in each neighboorhood
neigh=localeigenvectors(bfinegrid*0,neigh, Nx,Ny,additional_basis,Elements,vertex_list,mesh_parameter);
neigh=linearones(neigh,Nx,Ny,bfinegrid,vertex_list);

% computation of GMsFEM basis
neigh=GMsFEMbasis(neigh,Nx,Ny);

% computaiton of GMsFEM coarse matrix and coarse load vector
[R0GMsFEM,free0G,x0dG]=matrixR_GMsFEM(bfinegrid,neigh,Nx,Ny);
A0GMsFEM=R0GMsFEM'*Afinegrid*R0GMsFEM; %Tem que atualiza
b0G=R0GMsFEM'*bfinegrid-A0GMsFEM*x0dG; %Tem que atualiza

% compuation of GMsFEM approximation of the pressure
downz0G=compute_GMsFEMpressure(A0GMsFEM,b0G,R0GMsFEM,free0G,x0dG); %Tem que atualiza

%plot_vector(downz0G, dom,Nx,Ny,coefficient_values); title(['GMsFEM pressure']) ;view(2); shading flat
 figure(1)
surf(reshape(downz0G,Nx*nx+1,Ny*ny+1)');
% shading interp;
%   colormap('jet') ;
% pbaspect([4 1 1])
%trisurf(Elements(:,1:4),full(vertex_list(:,1)),full(vertex_list(:,2)), full(downz0G));

% postprocessing of the preassure for elements
pelement=compute_pressure_at_elements(downz0G, Nx,Ny,nx,ny);

 size(pelement)
% size(downz0G)

  figure(2)
% %%%%%%%%%%%%%%%%Jean%%
 surf(reshape(pelement,Nx*nx,Ny*ny)')
  shading interp;
  colormap('jet') 
pbaspect([4 1 1])
%%%%%%%%%%%%%%%%%





%%
% figure(3)
% subplot(1,2,1)
% surf(reshape(Elements(:,5),Nx*nx,Ny*ny)')
% view(2)
% title("coefficient")
% shading interp;
%   colormap('jet') ;
%   pbaspect([4 1 1])
% %axis square
% subplot(1,2,2)
% surf(reshape(pelement,Nx*nx,Ny*ny)')
% view(2)
% title("pressure")
% shading interp;
%   colormap('jet') ;
%   pbaspect([4 1 1])
%axis square



