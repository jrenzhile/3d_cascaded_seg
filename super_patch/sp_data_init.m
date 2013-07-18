function [neighbors, dist, faceCenter] = sp_data_init(vertex,face, verbose)
% function [neighbors, dist, faceCenter] = sp_data_init(vertex,face, verbose)
% Perform data initialization for super-patch algorithm.
% return neighbors, distance between neighboring faces where dist(i,j) is
% the distance between face j and neighbors(i,j), also return the center of
% each face.
%
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013

vertex_max = max(vertex(:));
vertex = vertex/vertex_max;

if verbose
    fprintf('Initializing Data..\n');
end

tmp_tic = tic;

faceNorm = compFaceNorm(vertex,face); %c function
if verbose
    tmp_toc = toc(tmp_tic);
    fprintf('Done Computing face Norm: %.2fs\n',tmp_toc);
end

neighbors = getNeighbor(face); %c function
if verbose
    tmp_toc = toc(tmp_tic)-tmp_toc;
    fprintf('Done Computing neighbors: %.2fs\n',tmp_toc);
end

phyDist = computePhyDist(vertex,face,neighbors); %matlab function
if verbose
    tmp_toc = toc(tmp_tic)-tmp_toc;
    fprintf('Done Computing phyDist: %.2fs\n',tmp_toc);
end

dihedralAngle = computeDihedralAngle(faceNorm,neighbors);%matlab function
dihedralAngle = 1-dihedralAngle.^2;
if verbose
    tmp_toc = toc(tmp_tic)-tmp_toc;
    fprintf('Done Computing dihedral angles: %.2fs\n',tmp_toc);
end

%b =[-6.7985;4.3733;52.6669];
b = [-6.4923;4.4844;15.7339];

dist = sigmoid(b(1) + b(2)*dihedralAngle + b(3)*phyDist);
if verbose
    tmp_toc = toc(tmp_tic)-tmp_toc;
    fprintf('Done Computing distance matrix: %.2fs\n',tmp_toc);
end

faceCenter = computeFaceCenter(vertex, face);
if verbose
    tmp_toc = toc(tmp_tic)-tmp_toc;
    fprintf('Done Computing face center: %.2fs\n',tmp_toc);
end
