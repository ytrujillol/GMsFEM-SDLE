function f = fj(u0,ordem)

N = length(u0);
I = 2:N-1;

% Dfp
D12(I) = fluxo1(u0(I+1)) - fluxo1(u0(I));
D12(1) = fluxo1(u0(2)) - fluxo1(u0(1));
D12(N) = fluxo1(u0(N-1));  
        
%Dfm
D_12(I) = fluxo1(u0(I)) - fluxo1(u0(I-1));
D_12(1) = fluxo1(u0(2));
D_12(N) = fluxo1(u0(N)) - fluxo1(u0(N-1));
      
switch ordem
    
    case 1
         
      %Derivadas minmod ordem 1
      f = MM(D12,D_12);

    case 2
       a = input('Entre o valor de alpha: ');
       % Derivada centrada
       D_2(I) = fluxo1(u0(I+1)) - fluxo1(u0(I-1));
       D_2(1) = fluxo1(u0(2)) - fluxo1(u0(1));
       D_2(N) = fluxo1(u0(1)) - fluxo1(u0(N-1));
       
       % minmod3
       f = MM3(a*D12,0.5*D_2,a*D_12);
       
    case 3
        
        % Derivada de segunda ordem j
        D_2j(I) = fluxo1(u0(I-1))-2*fluxo1(u0(I))+fluxo1(u0(I+1));
        D_2j(1) = fluxo1(u0(1))-2*fluxo1(u0(2))+fluxo1(u0(3));
        D_2j(N) = fluxo1(u0(N-1))-2*fluxo1(u0(N))+fluxo1(u0(1));
        
        % Derivada de segunda ordem j-1
        D_2j_1(I) = D_2j(I-1);
        D_2j_1(N) = D_2j(N-1);
        D_2j_1(1) = D_2j(N);
        
        % Derivada de segunda ordem j+1
        D_2jp1(I) = D_2j(I+1);
        D_2jp1(1) = D_2j(2);
        D_2jp1(N) = D_2j(1);        
        
        % minmod
        f = MM(D_12+0.5*MM(D_2j_1,D_2j),D12-0.5*MM(D_2j,D_2jp1));
        
end
        
      