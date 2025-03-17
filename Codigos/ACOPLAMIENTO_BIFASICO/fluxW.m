function fw=fluxW(u)

%  fw=u./( u.*u+ 0.5*(1-u).^2  );


% m=40;
% fw=m*u./( m*u.*u+ (1-u).^2  );
% fw=(u/0.5)./(u.*u/0.5+((1-u).*(1-u))./1.0    );

%  srw=0.2;
%  sro=0.15;
%  
% 
%  fw= ((((u-srw).^2)/((1-srw).^2))/0.05) ./ ((((u-srw).^2)/((1-srw).^2))./0.05)+ (((1-u./(1-sro)).^2))./10; 

viscW=1;
viscO=2;

krw = u.^2;
kro = (1-u).^2;

lambda = (krw ./ viscW) + (kro ./ viscO);

fw=(u./1)./(lambda);

end

