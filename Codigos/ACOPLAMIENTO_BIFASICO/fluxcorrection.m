function b=fluxcorrection(M,v,mesh,Boundary, leftfluxvalue)

% fprintf('Creating Sparse Matrices in subdomain \n');

% Cuadrature points in the reference triangle (See Braess)
%[xi,eta,omega]=setquadrature();


nvel=mesh.nv; % velocity degrees of freedom==number of vertices.
A=sparse(nvel,nvel);   % grad*grad   
b=sparse(nvel,1);       % right hand side part --->.
%Mul=sparse(npre,1);        % Lagrange multimplier to ensure zero pressure.

% odd loop
% h= waitbar(0,'Please wait...assambling stiffness');

for i=1:length(Boundary.left)
    
    %%%%%%%%%%%%%%%%%%%% LOAD VECTOR         %%%%%%%%%%%%%%%%%%%%%%%%%%
    flux=leftfluxvalue(i); %% Pode ser flux=1;
    e=Boundary.left(i);
    lcol=M(e,1:4);
    hy=abs( v(M(e,1),2)-v(M(e,4),2) );
    lbf=flux*(hy/2)*[1 0 0 1];

    b(lcol,1)=b(lcol,1)+lbf';
    %%%%%%%%%%%%%%%%%%%%%%% LAGRANGE MULTIPLIER %%%%%%%%%%%%%%%%%%%%%%%
    %Mul(M_f(i,:),1)=Mul(M_f(i,:),1)+localmul(M_f(i,:),v_f,mesh_f,xi,eta,omega);
end