% cotangent scheme of Laplace-Betrami operator
% The evecs and evals should be solving the generalized eigendecomposition
% problem A\phi=\lambda W\phi (smallest ones)
function [W A L] = laplacebetrami(surface)
% the surface input should be the one after init_surface
% W: the weight matrix
% A: area
% the laplace is L = diag(1./A)*W

if nargout < 2 || nargout >3
    error('Only accept 2 or 3 inputs');
end

nv = surface.nv;
A = zeros(nv, 1);
V = [surface.X, surface.Y, surface.Z];

notboundary = ~isnan(surface.ETRI);
notboundary = notboundary(:, 1) & notboundary(:, 2);
notboundary = find(notboundary);

alphatri = surface.ETRI(notboundary, 1);   % triangle idx of each edge
betatri = surface.ETRI(notboundary, 2);

II = surface.E(notboundary, 1);     % vertex idx of each none-boundary edge
JJ = surface.E(notboundary, 2);

alphaallv = surface.TRIV(alphatri, :)';
alphavbin = ((alphaallv~=repmat(II', 3, 1)) & (alphaallv~=repmat(JJ', 3, 1)));
alphaKK = alphaallv(alphavbin);

edge1 = V(II, :)-V(alphaKK, :);
edge2 = V(JJ, :)-V(alphaKK, :);

cosalpha = sum(edge1.*edge2, 2)./sqrt((sum(edge1.*edge1, 2).*sum(edge2.*edge2, 2)));
sinalpha = sqrt(1-cosalpha.^2);
cotalpha = cosalpha./sinalpha;


betaallv = surface.TRIV(betatri, :)';
betavbin = ((betaallv~=repmat(II', 3, 1)) & (betaallv~=repmat(JJ', 3, 1)));
betaKK = betaallv(betavbin);

edge1 = V(II, :)-V(betaKK, :);
edge2 = V(JJ, :)-V(betaKK, :);

cosbeta = sum(edge1.*edge2, 2)./sqrt((sum(edge1.*edge1, 2).*sum(edge2.*edge2, 2)));
sinbeta = sqrt(1-cosbeta.^2);
cotbeta = cosbeta./sinbeta;

WW = (cotalpha + cotbeta)/2;

W = sparse(II, JJ, WW, nv, nv);
W = max(W, W');

II = 1:nv;
JJ = II;
WW = full(sum(W));
W = sparse(II, JJ, WW) - W;

area = calcFaceArea(V', surface.TRIV');
for i=1:nv
    A(i) = sum(area(surface.VTRI{i}))/3;
end

if nargout == 3
    L = full(sparse(II, JJ, 1./A, nv, nv) * W);
%    L = (L+L')/2;
else
    L = 0;
end

end
