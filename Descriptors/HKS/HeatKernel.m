% compute the hks feature
function [hks] = HeatKernel(vertexs, faces, nbasis, allt, k)
% vertexs: [3 x nv]
% faces: [3 x nf]
% nbasis: number of hks
% allt: to compute the hks in time interval
% k: number of eigenvalues to approximate the heat kernel

if nargin < 4
	allt = [1024.00       1351.18       1782.89       2352.53       3104.19       4096.00];
end

if nargin < 5
	k = 200;
end

dim = length(allt);

	surface.X = vertexs(1, :)';
	surface.Y = vertexs(2, :)';
	surface.Z = vertexs(3, :)';
	surface.TRIV = faces';

	surface = init_surface(surface);

	[W A] = laplacebetrami(surface);
	A = sparse(1:length(A), 1:length(A), A);
    [V, D] = eigs(W, A, k, -1e-5);
    D = diag(D);
    [D, idx] = sort(D);
    V = V(:, idx);

	[idx] =  farthest_point_sample(surface, 'size', nbasis);

	hks = ...
        shiftdim(sum(...
        repmat(exp(-repmat(allt', 1, k).*repmat(abs(D'), dim, 1)), [1, 1, nbasis])...
        .*shiftdim(repmat(V(idx, :)'.^2, [1, 1, dim]), 2),...
        2), 2);

   
end
