   
function PRINCIPALSMBF8aa(tfinal)
 
 
%   format  short e 
  clf 
 clc
% clear all


add=6;
    tfinal =350;


ax =0;
bx =256;


 ay =0;
 by =64;
 
 

 m=128;

 
 

mx=m;
my=m/4;

hx=(bx-ax)/(mx);
hy=(by-ay)/(my);


% % % % % % 
x = linspace(ax,bx,mx+1);
y = linspace(ay,by,my+1);


xm =pm(x);
ym =pm(y);



Mx = length(xm);
My = length(ym);

 % W0= eta(xm,ym);
 W0=zeros(Mx, My);
% % % 
% % % 
   W0(1,:)=1;   
% 

 W=W0;

[Nx1,Ny1] = size(W0);
[xmed,ymed] =  meshgrid(xm,ym);  


cfl_LE=0.09;

 
  
 

  
% Criar a mobilidade atraves da funcao no arquivo mob.m
% mob = mob(s,viscW,viscO), onde s é a saturacao, viscW é a viscosidade da agua e 
% viscO é a viscosidade do oleo.
% A funcao mob é modela por:
% krw = s^2, permeabilidade relativa da agua
% kro = (1-s)^2, permeabilidade relativa do oleo
% lambda = (krw / viscW) + (kro / viscO)


 mob1=mob(W);

  %mob1=ones(size(W));

  [K] = PermeabilidadeK(Nx1,Ny1,hx,hy);
 %[K] = PermeabilidadeK(Nx1,Ny1,hx,hy);
K;


%%%% Criando a função offline(Fora da iteração)

   [p,Elements,Element_list,vertex_list,mesh_parameter,R0GMsFEM,free0G,x0dG,Nx,Ny,nx,ny,Boundary]=offline(ax,bx,ay,by,K,m,mob1,hx,hy, add);

  
   [ux,uy] = eliptic1(mob1,Nx1,Ny1,hx,hy,K,p);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


  
h=hx*hy;    
    
 k =deltatri(W,h,cfl_LE,Nx1,Ny1,ux,uy);
 
%  W(1,:) = ones(size(W(1,:)));


 tnp = 0;
 i_lg =0; 
   
tic 
% told=tnp;
while tnp<=tfinal
    
      
  

  
  
    I=1:Nx1;
    J=1:Ny1;  
       
%  Runge kutta de 2 ordem   
    c1W(I,J) = SEMIBIW5(W0(I,J)                  ,hx,hy,Nx1,Ny1,ux,uy);
    c2W(I,J) = SEMIBIW5(W0(I,J)+((k/2).*c1W(I,J)),hx,hy,Nx1,Ny1,ux,uy); 
    W(I,J) = W0(I,J)+k.*c2W(I,J);
   W0=W;
   
 W(1,:)=1*ones(size(W(1,:)));
   
  k = deltatri(W,h,cfl_LE,Nx1,Ny1,ux,uy);
       mob1=mob(W);
      
% 
       [p]=online(K,mob1,Elements,Element_list,vertex_list,mesh_parameter,R0GMsFEM,free0G,x0dG,Nx,Ny,nx,ny,hx,hy,W,Boundary );
% % % %   
   [ux,uy] = eliptic1(mob1,Nx1,Ny1,hx,hy,K,p); 

 
     



 


       %
 i_lg = i_lg+1;
 
tnp=tnp+k  




S=1-(W);

  

 
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);

% Aplicar colormap una sola vez
colormap('jet');

% --- Vista 3D ---
subplot(1,2,1)  % 1 fila, 2 columnas, primera gráfica (3D)
surf(W, 'EdgeColor', 'none'); % Superficie sin bordes
shading interp;
xlabel('$y$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16); % Cambia etiquetas
ylabel('$x$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16);
zlabel('$S_w$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16);
title(sprintf('Visualización 3D Saturación. t = 400, con %5i x %5i celdas', mx, my), 'FontSize', 16);

view([140, 40]);  % Ajusta la vista para mantener la orientación deseada
colorbar;
axis tight;
grid on;
hold on;


% --- Vista 2D ---
subplot(1,2,2) % Segunda columna: vista 2D
imagesc(W'); % Matriz como imagen en 2D
xlabel('$x$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$y$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16);
title(sprintf('Visualización 2D Saturación. t = 400, con %5i x %5i celdas', mx, my), 'FontSize', 16);
colorbar;

% Mantener la proporción 1:1 en la vista 2D
axis equal; 
xlim([0, mx]);  % Ajustar el rango del eje X
ylim([0, my]);  % Ajustar el rango del eje Y
set(gca, 'YDir', 'normal'); % Corregir si el eje Y está invertido
hold on;

end
 figure(2)
  
   

toc
tnp;
  cfl = cfl_LE*0.5;

  
 


% 
   quiver(xm,ym, ux(:,:)',uy(:,:)','LineWidth',1,'AutoScaleFactor',10);
% % axis equal tight;
% pbaspect([4 1 1])
 xlabel('$x$','FontName','Times','Interpreter','latex', 'FontSize', 16)
 ylabel('$y$','FontName','Times','Interpreter','latex', 'FontSize', 16)
 
 title(sprintf('Campo de velocidades, t =400 con %i x %i celdas',mx,my));

 figure(3)
% 
 pcolor(xmed, ymed, p'); 
shading interp; % Suaviza los colores eliminando las líneas entre celdas
colormap('jet');
colorbar;

xlabel('$x$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$y$', 'FontName', 'Times', 'Interpreter', 'latex', 'FontSize', 16);

title(sprintf('Presión, t = 400 con %i x %i celdas', mx, my));


%  
 
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 
%%%%Salvando os dados de saida


  comando = sprintf('mkdir resultados_%f', cfl);
  eval(comando);

 
  nome_SW = sprintf('resultados_%f/sw_%d_%d_%d.dat', cfl,mx, my, add);
    dlmwrite(nome_SW, W);





    nome_p = sprintf('resultados_%f/p_%d_%d_%d.dat', cfl,mx, my, tfinal);
     dlmwrite(nome_p, full(p));


%     
% %   
%  
  nome_ux = sprintf('resultados_%f/ux_%d_%d_%d.dat',cfl, mx, my, tfinal);
  dlmwrite(nome_ux, ux);
      
  nome_uy = sprintf('resultados_%f/uy_%d_%d_%d.dat', cfl,mx, my, tfinal);
  dlmwrite(nome_uy, uy);
  

 
% end









