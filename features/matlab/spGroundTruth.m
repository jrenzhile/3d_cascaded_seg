function gt = spGroundTruth(s1, s2, seginfo, gt_cell, face)

gt_all  = zeros(1, length(gt_cell));
for i = 1:length(gt_all)
    gtinfo  = gt_cell{i};
    seg_1 = sp_maxCoverGroundTruth(face,s1, seginfo, gtinfo);
    seg_2 = sp_maxCoverGroundTruth(face,s2, seginfo, gtinfo);
    if seg_1 == seg_2
        gt_all(i)  =1;
    end
end

gt = mean(gt_all);
