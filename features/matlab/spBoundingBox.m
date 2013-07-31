function  bbox  =  spBoundingBox(s, seginfo, vertex, face, bbox_Matrix)

% function  bbox  =  spBoundingBox(s, seginfo, vertex, face, bbox_Matrix)
% Choose from the bounding box matrix the bounding box for segment s
%
% jrenzhile@gmail.com
% July, 2013

if nargin<5
    bbox_Matrix = spBoundingBox_Matrix(vertex, face, seginfo);
end

bbox = bbox_Matrix(s, :);
