function bboxMatrix = spBoundingBox_Matrix(vertex, face, seginfo)
% function bboxMatrix = spBoundingBox_Matrix(vertex, face, seginfo)
% compute the matrix for the bounding boxes of each patch, 
% size(bboxMatix) = nSegs*6, where each row represents
% [XMIN XMAX YMIN YMAX ZMIN ZMAX] of each bounding box
%
% Zhile Ren<jrenzhile@gmail.com>
% July, 2013


if min(seginfo)==0
    seginfo = seginfo+1;
end
bboxMatrix = zeros(max(seginfo),6);

uniq_ind = unique(seginfo);
for i = 1:length(uniq_ind)
    face_i = face(:,seginfo==uniq_ind(i));
    uniq_vertex = unique(face_i(:));
    vertex_i   =vertex(:,uniq_vertex);
    bboxMatrix(i,:) =  boundingBox3d(vertex_i');
end