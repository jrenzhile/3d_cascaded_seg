function  neighbors = get_neighbors(face)

nFace  = size(face,2);
neighbors = zeros(size(face));

tic;
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
toc;