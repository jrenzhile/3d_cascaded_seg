% Numerical geometry of nonrigid shapes.
% (C) Alexander & Michael Bronstein, 2008.
% All rights reserved.

%rand('seed', 0);
load michael3;

%for k=1:10,
%    src = round(rand*(length(shape.X)-1))+1;
    src = 1:2000;
    D0 = repmat(Inf, [length(shape.X) 1]);
    D1 = D0;
    D2 = D0;
    D1(src(1)) = 0;
    D2(src(2)) = 0;
    D0(src) = 0;
    DM = fastmarch(shape.TRIV, shape.X, shape.Y, shape.Z, src, struct('mode', 'multiple')); % compute the geodesic distance between src and src
    DS1 = fastmarch(shape.TRIV, shape.X, shape.Y, shape.Z, D1, struct('mode', 'single'));  % compute the geodesic distance between src (0 idx) and all other points
    DS2 = fastmarch(shape.TRIV, shape.X, shape.Y, shape.Z, D2, struct('mode', 'single'));

    
    trisurf(shape.TRIV, shape.X, shape.Y, shape.Z, D); 
    axis image; axis off; shading interp; lighting phong; 
    view([-10 15]); camlight head; colormap hot;
    title(sprintf('Source at vertex %d', src));
    drawnow;
    
    pause;
%end
