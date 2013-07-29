function sp_gtsegnumber = sp_maxCoverGroundTruth(face,s, seginfo, gtinfo)

% function sp_gtinfo = sp_groundtruth(face, seginfo, gtinfo)
% for super patch segment s, find the segment
% of ground truth segmentation that 
% has the max overlap with it.
%
% Zhile Ren <jrenzhile@gmail.com>
% July, 2013

uniq_gt = unique(gtinfo);

seg_face = face(:,(seginfo==s));
seg_face = sort(seg_face, 1);

if isempty(seg_face)
    error('Face doesnot exist..\n')
end

intersect_num_faces = zeros(1,length(uniq_gt));

for i = 1:length(uniq_gt)
    face_gt = face(:,(gtinfo==uniq_gt(i)));
    face_gt = sort(face_gt, 1);
    intersect_num_faces(i) = sum(ismember(...
        seg_face', face_gt', 'rows'));
end

[~,sp_gtsegnumber] = max(intersect_num_faces);
 
if min(gtinfo)==0
    sp_gtsegnumber = sp_gtsegnumber -1;
end