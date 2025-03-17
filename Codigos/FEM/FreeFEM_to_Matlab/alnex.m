clear all
close all

x = linspace(0,1,20);
y = x';
%z = cos(x.*pi/2).*cos(y.*pi/2);
z = x .* (1 - x) .* y .* (1 - y);

subplot(2,2,1)
surf(x,y,z)
grid on
title('Solución exacta')
shading interp;
colorbar
xlabel('x')
ylabel('y')
colormap(jet)
view(2)

subplot(2,2,2)
surf(x,y,z)
grid on
title('Visualización 3D')
shading interp;
colorbar
xlabel('x')
ylabel('y')
zlabel('z')
colormap(jet)