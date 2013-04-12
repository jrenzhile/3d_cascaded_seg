function faceCenter = computeFaceCenter(vertex, face)
% function faceCenter = computeFaceCenter(vertex, face);
% compute the coordinate of the centers of each face.
%
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013


faceCenter = zeros(size(face));
for i = 1:size(face,2)
    faceCenter(:,i) = sum(vertex(:,face(:,i)),2)/3;
end
