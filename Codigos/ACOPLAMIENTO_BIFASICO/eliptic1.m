% function [ux,uy] = eliptic1(mob,Nx,Ny,hx,hy,K,p)
function [ux,uy] = eliptic1(mob,Nx,Ny,hx,hy,K,p)


%HMFEM 2D
% (x,y) em [0,1] x [0,1]:
%
% u      = -k grad(p)
% div(u) = 0
%
% Condicoes de contorno
% p   = 1 em x = 0
% p   = 0 em x = 1
% u.n = 0 em y = 0 e y = 1
%
% k = 1
%
%% DiscretizaÃ§Ã£o por HMFEM construindo sistema linear para pressao
%
%% UR + UL + UU + UD = Fh;
%% U_alpha = (Keff_alpha,alpha'/h)*(p - p_alpha');
%% U_alpha = (2K/h)*(p - l_alpha);
%% alpha = R,L,U,D; alpha' = L,R,D,U
%% Keff_alpha,alpha' = (2 K K_alpha')/(K + K_alpha')
%
% Inicializacao
%
%
M   = Nx*Ny; % Numero de elementos
h=hx*hy;
% hx  = Lx/Nx; % Espacamento de malha em x
% hy  = Ly/Ny; % Espacamento de malha em y


% Condicoes de contorno:
% Valores
bR = 0.0;
bL = 1.0;
bU = 0.0;
bD = 0.0;
% Tipos de contorno: 0 (dirichlet), 1 (Neumann)
boundaryR = 0;
boundaryL = 1;
boundaryU = 1;
boundaryD = 1;

% Alocacao das variaveis do problema:
% p  = zeros(Nx,Ny); % Aloca pressao
ux = zeros(Nx,Ny); % Aloca fluxo na direcao x = (uR + uL)/2
uy = zeros(Nx,Ny); % Aloca fluxo na direcao y = (uU + uD)/2
f  = zeros(Nx,Ny); % Aloca fonte
uR = zeros(Nx,Ny); % Aloca fluxo normal a direita  (R)
uL = zeros(Nx,Ny); % Aloca fluxo normal a esquerda (L)
uU = zeros(Nx,Ny); % Aloca fluxo normal acima      (U)
uD = zeros(Nx,Ny); % Aloca fluxo normal abaixo     (D)

cR = zeros(Nx,Ny); % Aloca coef da pressao a direita  (R)
cL = zeros(Nx,Ny); % Aloca coef da pressao a esquerda (L)
cU = zeros(Nx,Ny); % Aloca coef da pressao acima      (U)
cD = zeros(Nx,Ny); % Aloca coef da pressao abaixo     (D)

% Alocacao das variaveis do sistemas linear:
A  = sparse(M,M); % Aloca matriz
x  = zeros(M,1); % Aloca lado direito
b  = zeros(M,1); % Aloca lado direit

K;
%  ax=0;bx=256;
%  
%  ay=0;by=64;

 %[p] = testcode(ax,bx,ay,by,K);

% grad(i,j)=((p(i+1,j)-p(i-1,j))/2*hx)+((p(i,j+1)-p(i,j-1))/2*hy);
% Montando coeficientes de cada elemento:

for i=1:Nx
    for j=1:Ny
% internos
if i < Nx
    cR(i,j) = ((2*mob(i,j)*mob(i+1,j)*K(i,j)*K(i+1,j))/(mob(i,j)*K(i,j)+mob(i+1,j)*K(i+1,j)))/(h);
end

% internos
if i > 1
    cL(i,j) = ((2*mob(i,j)*mob(i-1,j)*K(i,j)*K(i-1,j))/(mob(i,j)*K(i,j)+mob(i-1,j)*K(i-1,j)))/(h);
end

% internos
if j < Ny
    cU(i,j) = ((2*mob(i,j)*K(i,j)*mob(i,j+1)*K(i,j+1))/(mob(i,j)*K(i,j)+mob(i,j+1)*K(i,j+1)))/(h);
end

% internos
if j > 1
    cD(i,j) = ((2*mob(i,j)*K(i,j)*mob(i,j-1)*K(i,j-1))/(mob(i,j)*K(i,j)+mob(i,j-1)*K(i,j-1)))/(h);
end

end
end

% fronteiras
for j = 1:Ny
    
    % Lado esquerdo 
    if boundaryL == 0 % Dirichlet boundary
      cL(1,j) = (2*mob(1,j)*K(1,j))/(hy*hy);
    elseif boundaryL == 1 % Neumann boundary
      cL(1,j) =  0.0;
    end %%endif
    
    % Lado Direito 
    if boundaryR == 0 % Dirichlet boundary
      cR(Nx,j) = (2*mob(Nx,j)*K(Nx,j))/(hy*hy);
    elseif boundaryR == 1 % Neumann boundary
      cR(Nx,j) = 0.0;
    end %%  endif
    end %%endfor


for i = 1:Nx
    
    % Lado Abaixo 
    if boundaryD == 0 % Dirichlet boundary
      cD(i,1) = (2*mob(i,1)*K(i,1))/(hx*hx);
    elseif boundaryD == 1 % Neumann boundary
      cD(i,1) = 0.0;
    end %%endif
    
    % Lado Acima 
    if boundaryU == 0 % Dirichlet boundary
      cU(i,Ny) = (2*mob(i,Ny)*K(i,Ny))/(hx*hx);
    elseif boundaryU == 1 % Neumann boundary
      cU(i,Ny) = 0.0;
    end %%endif
    end %%endfor


cR;
cU;



% Recuperacao do campo de velocidade


% Elementos internos
for i = 1:Nx-1
  for j = 1:Ny
    uR(i,j) = (cR(i,j)/hx)*(p(i,j) - p(i+1,j));
  end %%endfor
end %%endfor

for i = 2:Nx
  for j = 1:Ny
    uL(i,j) = (cL(i,j)/hx)*(p(i,j) - p(i-1,j));
  end %% endfor
end %%endfor

for i = 1:Nx
  for j = 1:Ny-1
    uU(i,j) = (cU(i,j)/hy)*(p(i,j) - p(i,j+1));
  end  %% endfor
end %%endfor

for i = 1:Nx
  for j = 2:Ny
    uD(i,j) = (cD(i,j)/hy)*(p(i,j) - p(i,j-1));
  end            %endfor
end           %endfor

% Cantos
i = Nx;
if boundaryR == 0 % Dirichlet boundary
  for j = 1:Ny
    uR(i,j) =(cR(i,j))*(p(i,j) - bR);
  end   %%%%  endfor
elseif boundaryR == 1 % Neumann boundary  
  for j = 1:Ny
    uR(i,j) = bR; %-bR;
  end          %%%%  endfor
end      %%%endif

i = 1;
if boundaryL == 0 % Dirichlet boundary
  for j = 1:Ny
    uL(i,j) =(cL(i,j))*(p(i,j) - bL);
  end   %%%%  endfor
elseif boundaryL == 1 % Neumann boundary  
  for j = 1:Ny
    uL(i,j) = -bL;
  end   %% endfor  
end   %%endif

j = Ny;
if boundaryU == 0 % Dirichlet boundary
  for i = 1:Nx
    uU(i,j) = (cU(i,j))*(p(i,j) - bU);
  end   %%% endfor  
elseif boundaryU == 1 % Neumann boundary  
  for i = 1:Nx
    uU(i,j) = bU; %-bU
  end  %% endfor
end   %%%endif

j = 1;

if boundaryD == 0 % Dirichlet boundary
  for i = 1:Nx
    uD(i,j) =(cD(i,j))*(p(i,j) - bD);
  end  %% endfor    
elseif boundaryD == 1 % Neumann boundary  
  for i = 1:Nx
    uD(i,j) = -bD;
  end   %%%  endfor
end  %%endif

% Recuperar direcoes x e y
for i = 1:Nx
  for j = 1:Ny
    ux(i,j) = (uR(i,j) -uL(i,j))/2 ;
    uy(i,j) = (uU(i,j) - uD(i,j))/2;
  end   %%endfor
end   %%endfor


