function sp_neighbors = sp_get_neighbors(face, seginfo,neighbors)

% function sp_neighbor_matrix = sp_get_neighbors(vertex, face, seginfo,neighbors)
% Get the list of neighbors for super-patch segmentation. 
% the variable neighbors is got by getNeighbor(face)
% 
% Zhile Ren<jrenzhile@gmail.com>
% Jul, 2013



if ~exist('neighbors','var')
    neighbors = getNeighbor(face); 
end

if min(seginfo(:))==0
    seginfo = seginfo+1;
end


sp_neighbor_matrix = ...
    sparse(max(seginfo), max(seginfo));


for i = 1:size(face,2)
    face_i = seginfo(i);
    for j = 1:size(neighbors,1)
        face_j = seginfo(neighbors(j,i));
        if face_i~=face_j
            sp_neighbor_matrix(face_i,face_j) = 1;
            sp_neighbor_matrix(face_j,face_i) = 1;
        end
    end
end

sp_neighbor_matrix = triu(sp_neighbor_matrix);
[neighbor_a neighbor_b] = find(sp_neighbor_matrix);
sp_neighbors = [neighbor_a neighbor_b];
