function phyDist = computePhyDist(vertex,face,neighbor)
    phyDist = zeros(size(neighbor));
    [m, n] = size(phyDist);
    for i = 1:m
        for j = 1:n
            phyDist(i,j) = computePhyDist_between(vertex,face,neighbor(i,j),j);
        end
    end
end


function phyDist_between = computePhyDist_between(vertex, face, a, b)

vertex_ind_a = face(:,a);
vertex_ind_b = face(:,b);
inters_ind = intersect(vertex_ind_a,vertex_ind_b);

if length(inters_ind)~=2
    fprintf('Not a neighboring pair!\n');
    return;
end



coord_a = zeros(3,1);
for ii = 1:3
    coord_a = coord_a + vertex(:,vertex_ind_a(ii))/3;
end
coord_b = zeros(3,1);
for ii = 1:3
    coord_b = coord_b + vertex(:,vertex_ind_b(ii))/3;
end

coord_center = (vertex(:,inters_ind(1))+vertex(:,inters_ind(2)))/2;

phyDist_between = sqrt(sum((coord_center-coord_a).^2)) + sqrt(sum((coord_center-coord_b).^2));

end