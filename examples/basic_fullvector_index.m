set(0, 'defaultFigureWindowStyle', 'docked')


% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  
for g = 1:10
    % Refractive indices:
    n1 = 3.34;          % Lower cladding
    n2(g) = 3.305+(g-1)*0.015;          % Core
    n3 = 1.00;          % Upper cladding (air)

    % Layer heights:
    h1 = 2.0;           % Lower cladding
    h2 = 1.3;           % Core thickness
    h3 = 0.5;           % Upper cladding

    % Horizontal dimensions:
    rh = 1.1;           % Ridge height
    rw = 1.0;           % Ridge half-width
    side = 1.5;         % Space on side

    % Grid size:
    dx = 0.0125;        % grid size (horizontal)
    dy = 0.0125;        % grid size (vertical)

    lambda = 1.55;      % vacuum wavelength
    nmodes = 1;         % number of modes to compute

    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(g),n3],[h1,h2,h3], ...
                                                rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neff(g)] = wgmodes(lambda,n2(g),nmodes,dx,dy,eps,'000A');


    fprintf(1,'neff = %.6f\n',neff(g));

    figure(g);
    subplot(1,2,1);
    contourmode(x,y,Hx(:,:,1));
    view ([0 0 90])
    title(['Hx (TE mode:' num2str(g) ')']); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(1,2,2);
    contourmode(x,y,Hy(:,:,1));
    view ([0 0 90])
    title(['Hy (TE mode:' num2str(g) ')']); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end  
end

figure(11)
x = linspace(3.305,3.44,10);
plot(x,neff);


