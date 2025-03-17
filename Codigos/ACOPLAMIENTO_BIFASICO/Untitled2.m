 %[X,Y] = meshgrid(-40:40,-40:40);
[X,Y,Z] = meshgrid(0:2,0:2, 0:2);

U = Y;
V = Z;
W=X;
 quiver3(X,Y,Z,U,V,W)
%quiver(X,Y,U,V)