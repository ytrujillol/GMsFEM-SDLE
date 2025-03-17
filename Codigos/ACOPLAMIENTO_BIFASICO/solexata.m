
function solexata(tempo)

mx=1024;
z = linspace(0,256,mx+1);
xm=pm(z);
xm= [0 xm  ];

x=xm;

cfl=0.15;
% t=100;

uexata=exabuckey(xm,tempo) 

%plot3(xm, 32*ones(length(xm)),uexata,'k','LineWidth',2); 

comando = sprintf('mkdir resultados_%f', cfl);
eval(comando);
% % % 
% % % % 

%       
 nome_UE = sprintf('resultados_%f/UE_%d_%d.dat', cfl,mx, tempo);
  dlmwrite(nome_UE, uexata);
  