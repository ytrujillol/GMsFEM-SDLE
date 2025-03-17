% load wind
% x5 = x(:,:,5);
% y5 = y(:,:,5);
% u5 = u(:,:,5);
% v5 = v(:,:,5);
% [startX,startY] = meshgrid(80,20:10:50);
% verts = stream2(x5,y5,u5,v5,startX,startY);
% lineobj = streamline(verts);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [x,y] = meshgrid(-2:0.25:2,-2:0.25:2); 
% z = x.*exp(-x.^2-y.^2);
% mesh(x,y,z)
% 
% 
% t = x-y;
% 
% surf(x,y,z,t,'FaceColor','interp')
% colormap(lines(6))
% 
% tol = 1e-10;
% mask = abs(t) < tol;
% x2 = x(mask);
% y2 = y(mask);
% z2 = z(mask);
% plot3(x2,y2,z2')
% plot(x2,z2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [X,Y,Z] = peaks(50);                                            % Create Surface Data
% figure
% surf(X,Y,Z)
% grid on
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% title('Surface Plot')
% Xval = 0.5;
% Yp = interp1(X(1,:), Y.', Xval);
% Zp = interp1(X(1,:), Z, Xval);
% figure
% plot(Yp, Zp, '-r')
% grid
% xlabel('Y')
% ylabel('Z')
% title(sprintf('Slice Through Surface At X = %.3f', Xval))
% 









% %%%%%%%%%%%%%%%%%%%%%%%%%%
 [X,Y] = meshgrid(-2:0.25:2,-2:0.25:2);
 Z = x.*exp(-x.^2-y.^2);
% [X,Y,Z] = peaks(75);                                            % Create Surface Data
figure
surf(X,Y,Z)
grid on
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Surface Plot')

Xval = 0.5;
Xp = interp1(X(1,:), X.', Xval);
Yp = interp1(X(1,:), Y.', Xval);
Zp = interp1(X(1,:), Z, Xval);
figure
%plot(Yp, Zp, '-r')
plot3(Xp,Yp,z2')
grid
xlabel('X')
ylabel('Y')

zlabel('Z')
title(sprintf('Slice Through Surface At X = %.3f', Xval))