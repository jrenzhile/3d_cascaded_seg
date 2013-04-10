% neighbors = get_neighbors(face);
% 
% Given the face of the model, return the neighboring pairs.
% Each row j in coloum i represent a neighboring face pair (i,j)
% 
% Zhile Ren <jrenzhile@gmail.com>
% Mar, 2013

function  neighbors = get_neighbors(face)

nFace  = size(face,2);
neighbors = zeros(size(face));


for i=1:nFace
    count = 1;
    for j= 1:nFace
        intersec = intersect(face(:,i),face(:,j));
        if length(intersec)==2
            neighbors(count,i)=j;
            count = count+1;
            if count>3
                break
            end
        end
    end
end
