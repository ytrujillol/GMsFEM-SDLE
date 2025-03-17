clf 
clc

ax =-1.5;
bx =1.5;

ay =-1.5;
by = 1.5;

tfinal =0.5;
cfl_LE=0.12;

m=128;

mx=m;
my=m;

hx = (bx-ax)/(mx);
hy = (by-ay)/(my);
h=hx*hy;

x = linspace(ax,bx,mx+1);
y = linspace(ay,by,my+1);

xi = mx:-1:1;
xi = -hx*xi + x(1);
xd = 1:mx;
xd = hx*xd + x(end);
xf = [xi,x,xd];

xm = pm(x);
ym = pm(x);

[xmed,ymed] =  meshgrid(xm,ym);

u0 = eta1(xm,ym);

u= u0;

Nx= length(xm);
Ny= length(ym);

k= delta(u0,hx,hy,cfl_LE);
 
tnp = 0; 
i_lg =0; 

while(tnp<tfinal)    
    c1=u0+k*SEMILEBUCKLEY2D(u0,hx,hy,Nx,Ny);
    c1=u0+k*SEMILEBUCKLEY2D(u0,hx,hy,Nx,Ny);
    c2=c1+k* SEMILEBUCKLEY2D(c1,hx,hy,Nx,Ny);
    u=0.5*(u0+c2);
        
    u0=u;
    i_lg =i_lg +1;
    tnp = tnp + k; 
end

cfl=0.5*cfl_LE
 
clf;
% ------------------------ Vista en 2D ------------------------ %
subplot(1,2,2) % Primer panel (izquierdo)
pcolor(xmed, ymed, u'); % Mapa de colores (2D)
shading interp; % Suaviza la interpolación de colores
colormap(jet); % Paleta de colores
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize', 16);
colorbar; % Barra de color
title(sprintf('Visualización 2D Saturación. t = %.2f, con %ix%i celdas', tfinal, mx, my), 'FontSize', 16);
axis equal; % Mantiene proporción entre los ejes
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);

% ------------------------ Vista en 3D ------------------------ %
subplot(1,2,1) % Segundo panel (derecho)
surf(xmed, ymed, u'); % Gráfico de superficie 3D
hold on;
%contour3(xmed, ymed, u', 30, 'k'); % Contornos en 3D
shading interp;
colormap(jet);
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize', 16);
zlabel('$S_w$', 'Interpreter', 'latex', 'FontSize', 16);
colorbar;
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
zlim([0 1]);
set(gca,'xtick',[-1.5:0.5:1.5]);
set(gca,'ytick',[-1.5:0.5:1.5]);
title(sprintf('Visualización 3D Saturación. t = %.2f, con %ix%i celdas', tfinal, mx, my), 'FontSize', 16);