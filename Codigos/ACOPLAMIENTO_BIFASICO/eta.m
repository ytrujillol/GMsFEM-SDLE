 function [f] = eta(xm,ym)
%
% ax =0;
% bx = 512;
% 
%  ay =0;
%  by =512;
% 
% m=128;
%  
%  mx=m;
%  my=m;
% 
%  hx = (bx-ax)/(mx);
%  hy = (by-ay)/(my);
%  
% 
% x = linspace(ax,bx,mx+1);
% y = linspace(ay,by,my+1);
% 
%  % 
% xi = mx:-1:1;
% xi = -hx*xi + x(1);
% xd = 1:mx;
% xd = hx*xd + x(end);
% xf = [xi,x,xd];
% 
% yi =2:-1:1;
% yi = -hy*yi + y(1);
% yd = 1:2;
% yd = hy*yd + y(end);
% yf = [yi,y,yd];
% 
% % Centros das celulas
% % xi = 3:-1:1;
% % xi = -h*xi + x(1);
% % xd = 1:m;
% % xd = h*xd + x(end);
% % xf = [xi,x,xd];
% 
% xm = pm(xf);
% ym = pm(y);
  [xmed,ymed] =  meshgrid(xm,ym);

 Nx = length(xm);
 Ny = length(ym);
% 
  for i = 1:Nx;
      for j = 1:Ny;  
%     
%      %buckley-leverett com trans
         if (xm(i)<0.0 ||  ym(j)<=0.0)
%      %%% fOR RP1 
              f(i,j) =1; 
              
              
          %fOR RP2  
%              f(i,j) =  0.721; 
%                 
         else 
             f(i,j) = 0.001;
            
             end  
         
         
    %end
   end
  end

%  surf(f)
%   figure(1)
