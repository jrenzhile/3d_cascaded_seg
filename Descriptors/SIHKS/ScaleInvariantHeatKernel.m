% compute the sihks feature
function [sihks] = ScaleInvariantHeatKernel(vertexs, faces, nbasis, dim, k)
% vertexs: [3 x nv]
% faces: [3 x nf]
% nbasis: number of sihks
% dim: output dimension of the sihks
% k: number of eigenvalues to approximate the heat kernel

if nargin < 4
    dim = 6;
end

if nargin < 5
	k = 200;
end

    alpha = 2;
    tao = 1/16;
    allt = alpha.^(1:tao:25);

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
        repmat(exp(-repmat(allt', 1, k).*repmat(abs(D'), length(allt), 1)), [1, 1, nbasis])...
        .*shiftdim(repmat(V(idx, :)'.^2, [1, 1, length(allt)]), 2),...
        2), 2);

    loghks = log(hks);
    sihks = (loghks(:, 2:end) - loghks(:, 1:end-1))/tao;
    sihks = fft(sihks, [], 2);
    sihks = sqrt(real(sihks).^2 + imag(sihks).^2);
    sihks = sihks(:, 1:dim);
   
end
