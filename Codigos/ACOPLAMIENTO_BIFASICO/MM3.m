function w = MM3(x,y,z)


% N = length(z);
% 
% for i = 1:N
%     
%     w(i) = MM( x(i), MM(y(i),z(i)));
% 
% endfunction w = MM3(x,y,z)


N = length(y);

% for i = 1:N
    
    w = MM(x,MM(y,z));

%end