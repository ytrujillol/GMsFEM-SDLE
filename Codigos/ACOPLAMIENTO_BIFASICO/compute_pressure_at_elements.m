
function pe=compute_pressure_at_elements(pvertex, Nx,Ny,nx,ny)


nex=Nx*nx;
ney=Ny*ny;

pe=sparse(nex,ney);
for j=1:ney
    for i=1:nex
        neI=nex*(j-1)+i;
        v1=(nex+1)*(j-1)+i;
        v2=(nex+1)*(j-1)+i+1;
        v3=(nex+1)*(j-1+1)+i+1;
        v4=(nex+1)*(j-1+1)+i;
        pe(neI)=mean( pvertex([v1,v2,v3,v4]));
    end
end