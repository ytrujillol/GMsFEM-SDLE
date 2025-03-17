function lambda = mob(s)
  
%# exemplo de funcao de modibildade.
% # s: ponto da saturacao
% #lambda: mobilidade
% #sw: parametro 

krw = s.^2;
kro = (1-s).^2;


viscW=1;
viscO=2; 

lambda =(krw ./ viscW) + (kro / viscO);

%endfunction
