% compute the shape dna feature
function [sdna] = ShapeDNA(vertexs, faces, neig)
% vertexs: [3 x nv]
% faces: [3 x nf]
% neig: number of eigenvalues

	surface.X = vertexs(1, :)';
	surface.Y = vertexs(2, :)';
	surface.Z = vertexs(3, :)';
	surface.TRIV = faces';

	surface = init_surface(surface);

	[W A] = laplacebetrami(surface);
	A = sparse(1:length(A), 1:length(A), A);
    [V, D] = eigs(W, A, neig, -1e-5);
   
	sdna = sort(diag(D));

end
