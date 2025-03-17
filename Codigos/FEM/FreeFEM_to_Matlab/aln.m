clear all
close all
addpath('C:\Users\ytruj\Downloads\FEM');
%Load the mesh
[p,b,t,nv,nbe,nt,labels]=ffreadmesh('capacitor.msh');
vh=ffreaddata('capacitor_vh.txt');
u=ffreaddata('capacitor_potential.txt');

subplot(2,2,1)
ffpdeplot(p,b,t,'VhSeq',vh,'XYData',u);
title('Solución con n = 50')
xlabel('x')
ylabel('y')
colormap(jet)

subplot(2,2,2)
ffpdeplot(p,b,t,'VhSeq',vh,'XYData',u,'ZStyle','continuous');
grid on
title('Visualización 3D')
xlabel('x')
ylabel('y')
zlabel('z')
colormap(jet)