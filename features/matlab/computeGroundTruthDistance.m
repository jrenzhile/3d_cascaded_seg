% gtDist = computeGroundTruthDistance(seginfo,neighbors)
% 
% Given seginfo and neighbor matrix, gtDist(i,j) is 1 if face neighbor(i,j)
% and face j are not belonging to the same segment and 0 otherwise
% 
% Zhile Ren <jrenzhile@gmail.com>
% Mar, 2013

function gtDist = computeGroundTruthDistance(seginfo,neighbors)
    gtDist = zeros(size(neighbors));
    [m, n] = size(gtDist);
    for i = 1:m
        for j = 1:n
            gtDist(i,j) = (seginfo(j)~=seginfo(neighbors(i,j)));
        end
    end
end

