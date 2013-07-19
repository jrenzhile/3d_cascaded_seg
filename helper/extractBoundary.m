function edges = extractBoundary(vertex, face, seginfo)

% function edges = extractBoundary(vertex, face, seginfo)
% Extract the boundary of a mesh segmentation, storinng in a matrix called
% edges(2*N), where each coloumn represents the vertex number of a line
% segment.
%
% Zhile Ren <jrenzhile@gmail.com>
% July, 2013

unique_segs = unique(seginfo);
edges = sparse(size(vertex,2),size(vertex,2));

for i = 1:length(unique_segs)
   face_i = face(:,seginfo==unique_segs(i));
   e2f = compute_edge_face_ring(face_i);
   [edge_1,edge_2] = find(e2f==-1);
   for j = 1:length(edge_1)
       edges(edge_1(j),edge_2(j)) = 1;
       edges(edge_2(j),edge_1(j)) = 1;
   end
end
[edge_1, edge_2] = find(triu(edges));
edges = zeros(2,length(edge_1));
edges(1,:) = edge_1';
edges(2,:) = edge_2';

