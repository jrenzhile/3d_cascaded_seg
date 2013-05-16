% Numerical geometry of nonrigid shapes.
% (C) Alexander & Michael Bronstein, 2008.
% All rights reserved.

rand('seed', 0);

% Generate the maze surface
N = 120;
[X,Y] = meshgrid(1:N,1:N);
Z = zeros(size(X));

ds = 20;
s = 20;
l = N-ds;
u = [1 s]';
v = [1 0]';
  for k=1:9,
    us = u;
    uf = u+v*l;
 
    Z(min(us(1),uf(1)):max(us(1),uf(1)), min(uf(2),us(2)):max(us(2),uf(2))) = 1;
    
    u = uf;
    v = [0 -1; 1 0]*v(:);
    s = s + ds;
    if mod(k-1,2) == 0,
        l = l - ds;
    end
    
  end

Z(Z==1) = 1e5;
  
imagesc(Z);
axis image;

X = single(X);
Y = single(Y);
Z = single(Z);

    D = zeros(size(X)) + Inf;
    
    imagesc(D.*double(Z==0));
    axis image; axis off;
    title('Maze surface');
    drawnow;

    for rep=1:5,
        [grid,initTime] = mexGeneralFMM('initGrid',X,Y,Z);
        [D,runTime,itersDeFacto]     = mexGeneralFMM('FMM',grid,uint32([sub2ind(size(X), round(N/2)+5, round(N/2)+5)]), ...
            single([0]),uint32(rep) );
        D(D>1e4) = Inf;

        pause;
        imagesc(D.*double(Z==0));
        axis image; axis off;
        drawnow;
        title(sprintf('Distance map after %d iterations', rep));
    end
    
    mexGeneralFMM('DeInitGrid',grid);

    
