function v = vj(u0,ordem)

N = length(u0);
I = 2:N-1;

% Dfp
D12(I) = u0(I+1) - u0(I);
D12(1) = u0(2) - u0(1);
D12(N) = u0(1) - u0(N);
        
%Dfm
D_12(I) = u0(I) - u0(I-1);
D_12(1) = u0(1) - u0(N);
D_12(N) = u0(N) - u0(N-1);
      
switch ordem
    
    case 1
         
      %Derivadas minmod ordem 1
      v = MM(D12,D_12);
      
    case 2
       b =2;%input('Entre o valor de alpha: ');
%       Derivada centrada
       D_2(I) = u0(I+1) - u0(I-1);
       D_2(1) = u0(2) - u0(N);
       D_2(N) = u0(1) - u0(N-1);
       
       % minmod3
       v= MM3(b*D12,0.5*D_2,b*D_12);
       
    case 3
        
        % Derivada de segunda ordem j
        D_2j(I) = u0(I-1)-2*u0(I)+u0(I+1);
        D_2j(1) = u0(N)-2*u0(1)+u0(2);
        D_2j(N) =D_2j(N-1);% u0(N-1)-2*u0(N)+u0(1);
        
        % Derivada de segunda ordem j-1
        D_2j_1(I) = D_2j(I-1);
        D_2j_1(N) = D_2j(N-1);
        D_2j_1(1) = D_2j(N);
        
        % Derivada de segunda ordem j+1
        D_2jp1(I) = D_2j(I+1);
        D_2jp1(1) = D_2j(2);
        D_2jp1(N) = D_2j(1);        
        
        % minmod UNO
       v = MM(D_12+0.5*MM(D_2j_1,D_2j),D12+0.5*MM(D_2j,D_2jp1));
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    case 4
        v1=MM(D12,2*D_12);
        v2=MM(2*D12,D_12);
       v=MaxMod(v1,v2);
       
   case 5
       p1=max(0, max(2*D12,1));
       
       v=D_12.*max( p1, max(D12,2));
       
    case 6
        b=2;
        D_2(I) = u0(I+1) - u0(I-1);
       D_2(1) = u0(2) - u0(N);
       D_2(N) = u0(1) - u0(N-1);
        v= D_12+ MM(D12,D_12)
       
end