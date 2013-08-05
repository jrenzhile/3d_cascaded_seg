function [X,y] =  ...
    construct_feature_vector(infoAll,mod_to_train,truc_pct, verbose)
% [X,y] =  construct_feature_vector(featuredir,gtdir, mod_to_train,truc, verbose);
% construct featuure vector X y, where each row represent a pair of
% neighbors, and X represent pairwise features, 
% y represent the ground truth similarity.
% truc_pct: if 0<trunc_pct<1, we'll truncate the data with this percentage 
% in order to save memory.
% 
% Zhile Ren <jrenzhile@gmail.com>
% Aug, 2013

X = [];
y = [];
tot_time = tic;
for i = 1:length(mod_to_train)
    seg = infoAll{mod_to_train(i)};
    
    
    X_i = seg.segstruct.P;
    y_i = zeros(size(seg.segstruct.P, 1), 1);
    
    nums = ceil(truc_pct * length(y_i));
    mod_to_choose_ind = randperm(length(y_i),nums);
    mod_to_choose = zeros(1,length(y_i));
    mod_to_choose(mod_to_choose_ind) = 1;
    mod_to_choose = logical(mod_to_choose);
    X_i = X_i(mod_to_choose,:);
    y_i = y_i(mod_to_choose);
    
    sp_neighbors = seg.segstruct.sp_neighbors(mod_to_choose,:);
    
    
    
    gt_time = tic;
    for j = 1:length(y_i)
        y_i(j) = ...
            spGroundTruth(sp_neighbors(j,1),sp_neighbors(j,2), seg.seginfo, seg.gt_cell, seg.face);
    end
    
    if verbose
        fprintf('Done Computing Ground Truth for model %d: %.2fs\n',i, toc(gt_time));
    end
    
    X = [X;X_i];
    y = [y;y_i];
    
end

if verbose
    fprintf('Feature construction done: %.2fs\n',toc(tot_time));
end
