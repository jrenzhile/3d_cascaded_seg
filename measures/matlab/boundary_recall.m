function br = boundary_recall(vertex, face, seginfo, gtinfo, tolerance)

% uniq_seg = unique(seginfo);
% new_seg = zeros(1,length(uniq_seg));
% 
% for i = 1:length(uniq_seg)
%     new_seg(i) = ...
%         sp_maxCoverGroundTruth(face,uniq_seg(i), seginfo, gtinfo);
% end

edge_seg = extractBoundary(vertex, face, seginfo);
edge_gt = extractBoundary(vertex,face, gtinfo);


vertex = vertex/max(vertex(:)); % Normalize
dist_below_tolerance = 0;

for j = 1:size(edge_gt, 2);
    for i = 1:size(edge_seg,2)
        dist = DistBetween2LineSegment_mex(vertex(:,edge_seg(1,i))', vertex(:,edge_seg(2,i))',...
            vertex(:,edge_gt(1,j))',vertex(:,edge_gt(2,j))');
        if dist<tolerance
            dist_below_tolerance = dist_below_tolerance+1;
            break;
        end
    end
 %   fprintf('Done %.2f%%\n', j/size(edge_gt,2)*100);
end

br = dist_below_tolerance/size(edge_gt,2);



% 
% p1 = cell(size(edge_gt, 2)*size(edge_seg, 2),1);
% p2 = p1;
% p3 = p1;
% p4 = p1;
% edge_seg_matrix_p1 = zeros(size(edge_gt, 2)*size(edge_seg, 2),3);
% edge_seg_matrix_p2 = edge_seg_matrix_p1;
% edge_gt_matrix_p1 = edge_seg_matrix_p1;
% edge_gt_matrix_p2 = edge_seg_matrix_p1;
% 
% tmp = zeros(size(edge_seg,2),3);
% for i = 1:size(edge_seg,2)
%     tmp(i,:) = vertex(:,edge_seg(1,i))';
% end
% edge_seg_matrix_p1 = repmat(tmp, size(edge_gt,2),1);
% 
% for i = 1:size(edge_seg,2)
%     tmp(i,:) = vertex(:,edge_seg(2,i))';
% end
% edge_seg_matrix_p2 = repmat(tmp, size(edge_gt,2),1);
% 
% tmp = zeros(size(edge_gt,2),3);
% for i = 1:size(edge_gt,2)
%     tmp(i,:) = vertex(:,edge_gt(1,i))';
% end
% for i = 1:size(edge_gt,2)
%     edge_gt_matrix_p1(1+(i-1)*size(edge_seg,2):i*size(edge_seg,2),:) = ...
%         repmat(tmp(i,:), size(edge_seg,2), 1);
% end
% for i = 1:size(edge_gt,2)
%     tmp(i,:) = vertex(:,edge_gt(2,i))';
% end
% for i = 1:size(edge_gt,2)
%     edge_gt_matrix_p2(1+(i-1)*size(edge_seg,2):i*size(edge_seg,2),:) = ...
%         repmat(tmp(i,:), size(edge_seg,2), 1);
% end
% 
% 
% 
% for i = 1:length(p1)
%     p1{i} = edge_seg_matrix_p1(i,:);
% end
% for i = 1:length(p2)
%     p2{i} = edge_seg_matrix_p2(i,:);
% end
% for i = 1:length(p3)
%     p3{i} = edge_gt_matrix_p1(i,:);
% end
% for i = 1:length(p3)
%     p4{i} = edge_gt_matrix_p2(i,:);
% end
% 
% res = cellfun(@DistBetween2LineSegment, p1,p2,p3,p4);
% dist = reshape(res, size(edge_gt,2), size(edge_seg,2));
% min_dist = min(dist');
% br = sum(min_dist<tolerance)/length(min_dist);
% 
