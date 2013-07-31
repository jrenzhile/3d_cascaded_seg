function maxIntersect = spBBoxIntersect(box1, box2)

% function maxIntersect = spBoxIntersect(box1, box1)
% maxIntersect = max(vBox_Intersect/vBox_1, vBox_Intersect/vBox_2);
%
% Zhile Ren<jrenzhile@gmail.com>
% July, 2013

boxIntersect =  intersectBoxes3d(box1, box2);

vBox_1 =  box3dVolume(box1);
vBox_2 = box3dVolume(box2);
vBox_Intersect = box3dVolume(boxIntersect);

maxIntersect = max(vBox_Intersect/vBox_1, vBox_Intersect/vBox_2);