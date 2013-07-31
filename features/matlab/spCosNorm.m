function cosNorm = spCosNorm(norm1, norm2)

% function function cosNorm = spCosNorm(norm1, norm2)
% the cosine of two vectors
%
% Zhile Ren<jrenzhile@gmail.com>
% July, 2013

if size(norm1,2)>size(norm1,1)
    norm1 = norm1';
end

if size(norm2,2)>size(norm2,1)
    norm2 = norm2';
end

cosNorm = norm1' * norm2/sqrt(sum(norm1.^2)*sum(norm2.^2));

