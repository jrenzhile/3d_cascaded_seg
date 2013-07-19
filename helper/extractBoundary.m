function edges = extractBoundary(vertex, face, seginfo)

% function edges = extractBoundary(vertex, face, seginfo)
% Extract the boundary of a mesh segmentation.
%
% Zhile Ren <jrenzhile@gmail.com>
% July, 2013

unique_segs = unique(seginfo);
edges = compute_edges(face);

for i = 1:length(unique_segs)
   face_i = face(:,seginfo==unique_segs(i));
   e2f = compute_edge_face_ring(face_i);
   [edge_1,edge_2] = find(triu(e2f));
   for j = 1:length(edge_1)
       if e2f(edge_1(j),edge_2(j))==e2f(edge_2(j),edge_1(j))
           disp('haha\n');
           continue;
       end
       erase_edge = find(edges(1,:)==edge_1(j));
       erase_edge_ind = find(edges(2,erase_edge)==edge_2(j));
       if length(erase_edge_ind)~=1
          % keyboard;
       end
       edges(:,erase_edge(erase_edge_ind))=[];
   end
end
