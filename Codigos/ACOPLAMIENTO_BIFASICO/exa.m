function f = exa(x,y,t)

%f = y - exp(-(x-y*t)^2);
% f = 0.5 + sin(x - y*t) - y;
%f = 0.1 + 0.1*sin(2*pi*(x - y*t)) - y;
%f = y^2 - (0.1 + 0.1*sin(2*pi*(x - y*t)));
f = y.*(1-y)*t + fun(x-y*t) - y;
%f = fun(x-y*t) - y;
%f = y - 5*atan(x-y*t);
%ezplot('y - exp(-(x-y*t)^2)')