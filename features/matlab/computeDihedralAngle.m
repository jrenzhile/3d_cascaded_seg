% dihedralAngle = computeDihedralAngle(faceNorm,neighbors)
% 
% Given faceNorm and neighbor matrix, dihedralAngle(i,j) is the 
% cosin of dihedral angle between face neighbor(i,j) and face j.
% 
% Zhile Ren <jrenzhile@gmail.com>
% Mar, 2013

function dihedralAngle = computeDihedralAngle(faceNorm,neighbors)
    dihedralAngle = zeros(size(neighbors));
    [m, n] = size(dihedralAngle);
    for j = 1:n
        norm_j = faceNorm(:,j);
        for i = 1:m
            norm_i = faceNorm(:,neighbors(i,j));
            dihedralAngle(i,j) = (norm_i'*norm_j)/(sqrt(sum(norm_i.^2))*...
                sqrt(sum(norm_j.^2)));
        end
    end
end

