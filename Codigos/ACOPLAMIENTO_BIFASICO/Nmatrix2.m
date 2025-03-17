function [A,b]=Nmatrix2(M,v,mesh)

% fprintf('Creating Sparse Matrices in subdomain \n');

% Cuadrature points in the reference triangle (See Braess)
%[xi,eta,omega]=setquadrature();


nvel=mesh.nv; % velocity degrees of freedom==number of vertices.
A=sparse(nvel,nvel);   % grad*grad   
b=sparse(nvel,1);       % right hand side part --->.
%Mul=sparse(npre,1);        % Lagrange multimplier to ensure zero pressure.

% odd loop
% h= waitbar(0,'Please wait...assambling stiffness');
 lA=localA(M(1,1:4),v); % compute local part of A

connectivity = M(:, 1:4); % N x 4 matrix of node indices
coefficients = M(:, 5);   % N x 1 vector of coefficients

N = size(M, 1);

rows = zeros(16 * N, 1); % Each element contributes 16 entries (4x4 matrix)
cols = zeros(16 * N, 1);
vals = zeros(16 * N, 1);

index = 1;
for i = 1:4
    for j = 1:4
        rows(index:index+N-1) = connectivity(:, i);
        cols(index:index+N-1) = connectivity(:, j);
        vals(index:index+N-1) = coefficients * lA(i, j);
        index = index + N;
    end
end

% Assemble the global stiffness matrix using sparse
A = sparse(rows, cols, vals, nvel, nvel);

b = sparse(nvel, 1);
