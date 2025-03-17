function[ux,uy] =hmfem(Nx, Ny)

%HMFEM 2D
% (x,y) em [0,1] x [0,1]:
%
% u      = -k grad(p)
% div(u) = 0
%
% Condicoes de contorno
% p   = 0 em x = 0
% p   = 1 em x = 1
% u.n = 0 em y = 0 e y = 1
%
% k = 1
%
% Discretização por HEMFEM construindo sistema linear para pressao
%
% UR + UL + UU + UD = Fh;
% U_alpha = (Keff_alpha,alpha'/h)*(p - p_alpha');
% U_alpha = (2K/h)*(p - l_alpha);
% alpha = R,L,U,D; alpha' = L,R,D,U
%Keff_alpha,alpha' = (2 K K_alpha')/(K + K_alpha')
%
% Inicializacao
%
%


Nx = 512;  % Numero de pontos em x
Ny = 128 ; % Numero de pontos em y
M  = Nx*Ny; % Numero de elementos
Lx  =512; %1200; % Tamanho do domínio em x
Ly  =128; % 2200; % Tamanho do domínio em y
hx  = Lx/Nx; % Espacamento de malha em x
hy  = Ly/Ny; % Espacamento de malha em y


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

% Tipo de permeabilidade:
% perm = 1, homogeneo
% perm = 2, SPE 10, e dê a layer
perm = 2;
layer = 36;

% Alocacao das variaveis do problema:
p  = zeros(Nx,Ny); % Aloca pressao
ux = zeros(Nx,Ny); % Aloca fluxo na direcao x = (uR + uL)/2
uy = zeros(Nx,Ny); % Aloca fluxo na direcao y = (uU + uD)/2
f  = zeros(Nx,Ny); % Aloca fonte
K  = zeros(Nx,Ny);        % Permeabilidade K
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
b  = zeros(M,1); % Aloca lado direito

% Permeabilidade:

if perm == 1 % homogenea
  K(:,:) = 1.0;

elseif perm == 2 % SPE 2D
  nxG =220;
  nyG = 60;
  nzG = 85;
  permeab = sprintf('spe_perm.dat');
  fid = fopen(permeab,'r');
  a = fscanf(fid,'%e');

q = 1;
for k = nzG:-1:1
     for j = 1:nyG
         for i = 1:nxG
            J=nyG-j+1;
            Px(i,J,k) = a(q,1);
            q = q+1;
         end %%  endfor
         end %% endfor
     end %%endfor
fclose(fid);

x_L = linspace(0,Lx,Nx);
y_L = linspace(0,Ly,Ny);
%z_L = linspace(0,170,nzG);
 
[x,y] = meshgrid(y_L,x_L);

Kxx = Px(:,:,nzG - layer + 1);

% Project Kxx into the Grid 
x2 = x(:,:,1);
y2 = y(:,:,1);

X = linspace(hx,Lx,Nx);
Y = linspace(hy,Ly,Ny);

for i=1:Nx
    for j=1:Ny
        i_geo = round(X(i)/hx);
        j_geo = round(Y(j)/hy);       
        K(i,j)=Kxx(i_geo,j_geo);
    end %%endfor
    end %%endfor

end %%endif

% Montando coeficientes de cada elemento:

for i=1:Nx
    for j=1:Ny
% internos
if i < Nx
    cR(i,j) = ((2*K(i,j)*K(i+1,j))/(K(i,j)+K(i+1,j)))/(hx*hx);
end

% internos
if i > 1
    cL(i,j) = ((2*K(i,j)*K(i-1,j))/(K(i,j)+K(i-1,j)))/(hx*hx);
end

% internos
if j < Ny
    cU(i,j) = ((2*K(i,j)*K(i,j+1))/(K(i,j)+K(i,j+1)))/(hy*hy);
end

% internos
if j > 1
    cD(i,j) = ((2*K(i,j)*K(i,j-1))/(K(i,j)+K(i,j-1)))/(hy*hy);
end

end
end

% fronteiras
for j = 1:Ny
    
    % Lado esquerdo 
    if boundaryL == 0 % Dirichlet boundary
      cL(1,j) = (2*K(1,j))/(hx*hx);
    elseif boundaryL == 1 % Neumann boundary
      cL(1,j) = 0.0;
    end %%endif
    
    % Lado Direito 
    if boundaryR == 0 % Dirichlet boundary
      cR(Nx,j) = (2*K(Nx,j))/(hx*hx);
    elseif boundaryR == 1 % Neumann boundary
      cR(Nx,j) = 0.0;
    end %%  endif
    end %%endfor


for i = 1:Nx
    
    % Lado Abaixo 
    if boundaryD == 0 % Dirichlet boundary
      cD(i,1) = (2*K(i,1))/(hy*hy);
    elseif boundaryD == 1 % Neumann boundary
      cD(i,1) = 0.0;
    end %%endif
    
    % Lado Acima 
    if boundaryU == 0 % Dirichlet boundary
      cU(i,Ny) = (2*K(i,Ny))/(hy*hy);
    elseif boundaryU == 1 % Neumann boundary
      cU(i,Ny) = 0.0;
    end %%endif
    end %%endfor


cR;
cU;


% Montando a Matriz A

% Elementos internos 
for i=1:Nx
for j=1:Ny
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s) = (cR(i,j) + cL(i,j) + cU(i,j) + cD(i,j)); % Centro
end
end    

for i=2:Nx-1
for j=2:Ny-1
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s+1) = -cR(i,j); 
    A(s,s-1) = -cL(i,j); 
    A(s,s+Nx) = -cU(i,j); 
    A(s,s-Nx) = -cD(i,j); 
end
end  

% Bordas:
% esquerda
i=1;
for j=2:Ny-1
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s+1) = -cR(i,j); 
    A(s,s+Nx) = -cU(i,j); 
    A(s,s-Nx) = -cD(i,j);  
end %%endfor

% Direita
i=Nx;
for j=2:Ny-1
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s-1) = -cL(i,j); 
    A(s,s+Nx) = -cU(i,j); 
    A(s,s-Nx) = -cD(i,j); 
end %%endfor

% Abaixo
j=1;
for i=2:Nx-1
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s+1) = -cR(i,j);
    A(s,s-1) = -cL(i,j); 
    A(s,s+Nx) = -cU(i,j); 
end %%endfor

% Acima
j=Ny;
for i=2:Nx-1
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s+1) = -cR(i,j);
    A(s,s-1) = -cL(i,j); 
    A(s,s-Nx) = -cD(i,j); 
end %%endfor

% As pontas:
% esquerda inferior:
i = 1;
j = 1;
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s+1) = -cR(1,1);
    A(s,s+Nx) = -cU(1,1);
% direita inferior:
i = Nx;
j = 1;
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s-1) = -cL(Nx,1);
    A(s,s+Nx) = -cU(Nx,1);
% esquerda superior:
i = 1;
j = Ny;
    s = (i-1) + Nx*(j-1) + 1;
    A(s,s+1) = -cR(1,Ny);
    A(s,s-Nx) = -cD(1,Ny);
% direita superior:
i = Nx;
j = Ny;
    s = (i-1) + Nx*(j-1) + 1
    A(s,s-1) = -cL(Nx,Ny);
    A(s,s-Nx) = -cD(Nx,Ny);
    
    
% Montando o Lado direito (RHS)

% Montamos a fonte primeiro
for j = 1:Ny
    
    % Lado esquerdo 
    if boundaryL == 0 % Dirichlet boundary
      f(1,j) = f(1,j) + cL(1,j)*bL;
    elseif boundaryL == 1 % Neumann boundary
      f(1,j) = f(1,j) + bL/hx;
    end %% endif
    
    % Lado Direito 
    if boundaryR == 0 % Dirichlet boundary
      f(Nx,j) = f(Nx,j) + cR(Nx,j)*bR;
    elseif boundaryR == 1 % Neumann boundary
      f(Nx,j) = f(Nx,j) + bR/hx;
    end %%endif
    
    end %%endfor

for i = 1:Nx
    
    % Lado Abaixo 
    if boundaryD == 0 % Dirichlet boundary
      f(i,1) = f(i,1) + cD(i,1)*bD;
    elseif boundaryD == 1 % Neumann boundary
      f(i,1) = f(i,1) + bD/hy;
    end %%endif
    
    % Lado Acima 
    if boundaryU == 0 % Dirichlet boundary
      f(i,Ny) = f(i,Ny) + cU(i,Ny)*bU;
    elseif boundaryU == 1 % Neumann boundary
      f(i,Ny) = f(i,Ny) + bU/hy;
    end %%  endif
    end %%endfor

% Transformo o RHS f (array 2d) em um vetor 
for j=1:Ny
  for i=1:Nx
    % Diagonal
    s = (i-1) + Nx*(j-1) + 1;
    b(s,1) = f(i,j);
  end %% endfor
end %%endfor

A;

x = A\b;

for j=1:Ny
  for i=1:Nx
    % Diagonal
    s = (i-1) + Nx*(j-1) + 1;
    p(i,j) = x(s,1);
  end %%endfor
end %%endfor

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
    uR(i,j) = (cR(i,j)/hx)*(p(i,j) - bR);
  end   %%%%  endfor
elseif boundaryR == 1 % Neumann boundary  
  for j = 1:Ny
    uR(i,j) = -bR;
  end          %%%%  endfor
end      %%%endif

i = 1;
if boundaryL == 0 % Dirichlet boundary
  for j = 1:Ny
    uL(i,j) = (cL(i,j)/hx)*(p(i,j) - bL);
  end   %%%%  endfor
elseif boundaryL == 1 % Neumann boundary  
  for j = 1:Ny
    uL(i,j) = -bL;
  end   %% endfor  
end   %%endif

j = Ny;
if boundaryU == 0 % Dirichlet boundary
  for i = 1:Nx
    uU(i,j) = (cU(i,j)/hy)*(p(i,j) - bU);
  end   %%% endfor  
elseif boundaryU == 1 % Neumann boundary  
  for i = 1:Nx
    uU(i,j) = bU;
  end  %% endfor
end   %%%endif

j = 1;

if boundaryD == 0 % Dirichlet boundary
  for i = 1:Nx
    uD(i,j) = (cD(i,j)/hy)*(p(i,j) - bD);
  end  %% endfor    
elseif boundaryD == 1 % Neumann boundary  
  for i = 1:Nx
    uD(i,j) = bD;
  end   %%%  endfor
end  %%endif

% Recuperar direcoes x e y
for i = 1:Nx
  for j = 1:Ny
    ux(i,j) =(uR(i,j) - uL(i,j))/2;
    uy(i,j) = (uU(i,j) - uD(i,j))/2;
  end   %%endfor
end   %%endfor

p;
size(uy)
% Plot Pressure
figure(1)
x_L = linspace(0,Lx,Nx);
y_L = linspace(0,Ly,Ny);

[yy,xx] = meshgrid(y_L,x_L);

xslice = [0,Lx];    
yslice = [0,Ly];    

surf(yy,xx,p);
xlabel ("y");
ylabel ("x");
title("Pressure");

% Plot velocity
figure(2)
  
quiver(yy,xx,uy(:,:),ux(:,:),'LineWidth',1,'AutoScaleFactor',20);
axis equal tight;
xlabel ("y");
ylabel ("x");
title("Velocity Field");

figure(3)
surface(x2,y2,log10(K))
% Create xlabel
xlabel('y','FontName','Times','Interpreter','latex', 'FontSize', 20);
% Create ylabel
ylabel('x','FontName','Times','Interpreter','latex', 'FontSize', 20);
str = sprintf("SPE 10 layer %d",layer);
title(str);
%surface(x2,y2,P)
xlim([0 Ly])
ylim([0 Lx])
shading flat
colormap 'jet'
set(gca,'fontsize',20)
set(gcf, 'Position', [1 1 1440 900]);

