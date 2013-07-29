function face_area = computeFaceArea(vertex, face)

% function face_area = computeFaceArea(vertex, face)
% Compute the area of each face
%
% Zhile Ren<jrenzhile@gmail.com>
% Jul, 2013



face_area = zeros(size(face, 2), 1);

for i = 1:length(face_area)
    pt1 = vertex(:,face(1,i))';
    pt2 = vertex(:,face(2,i))';
    pt3 = vertex(:,face(3,i))';
    v12 = bsxfun(@minus, pt2, pt1);
    v13 = bsxfun(@minus, pt3, pt1);
    face_area(i) = vectorNorm3d(cross(v12, v13, 2)) / 2;
end
