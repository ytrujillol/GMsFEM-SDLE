function  PRINCIPALSEMINLGRare(m)
    format  short e 
      
    clf 
    clc
    
    a=1;
    
    ax = -2;
    bx = 2;
    ay = -1.1;
    by = 1.1;
    
    tfinal =0.75;
    
    entrada = [ax  bx ay by];
     
    m=30;
    h = (bx-ax)/(m);
    
    x = linspace(ax,bx,m+1); 
    
    ym= pm(x);
    
    u0=eta7(ym);
    
    u = u0;
    
    N = length(u0);
    cfl_lg=0.2;
    
    I =1:N;                            
    
    k= delta(u0,h,cfl_lg);
    i_lg=0;
    
    tnp = 0;
    tic 
    while(tnp<tfinal) 
        tnp=tnp+k;  
        c1 = SEMINLGRare(u0(I),h,N,k);
        c2 = SEMINLGRare(u0(I)+((k/2)*c1),h,N,k); 
        u(I) = u0(I)+k.*c2;
        u0=u;
        i_lg=i_lg+1;
    end
    toc
    cfl = cfl_lg*0.5;
    
    uexata= exarare2(ym,tnp);
    plot(ym, u, 'r-', ym, uexata, 'k-', 'MarkerSize', 2.5, 'LineWidth', 0.6);
    legend('SDLE', 'Solución exacta', 'location', 'northwest'); % 'northwest'
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$u$', 'Interpreter', 'latex', 'FontSize', 14);
    title(sprintf('$t = %1.2f$, %5i Celdas', tfinal, m), 'Interpreter', 'latex', 'FontSize', 14);
    
    axis(entrada);
    grid on;
    
    figure(1);