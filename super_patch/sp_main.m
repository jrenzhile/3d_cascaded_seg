function seginfo = sp_main(face, vertex, sp_num, verbose)
% function seginfo = sp_main(face, vertex, sp_num, verbose)
% Perform super-patch segmentation of an arbitrary 3d triangular mesh model.
% Partition the model into sp_num pieces, seginfo is 
% 
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013

sp_tic = tic;
[neighbors, dist, faceCenter] = sp_data_init(vertex,face, verbose);

num_face = size(face,2); %number of faces
seginfo = -ones(num_face,1); %labeling of each face
minDist = inf(num_face,1); %minimum distance from face to center
init_center =  randperm(num_face,sp_num); %initial centers for k means
new_center = zeros(size(init_center)); %new centers for k means
faceCenter_init = faceCenter(:,init_center); %initial face centers

done = 0;
err_init = 0;
iteration_count = 0;
tolerance = 0.001;

while ~done
    iteration_count = iteration_count+1;
    iteration_tic = tic;
    if verbose
        fprintf('Iteration #%d:\n',iteration_count);
    end
    for i = 1:length(init_center)
        minDist_single = spfa_c(neighbors, dist, init_center(i)); %spfa
        for ii = 1:num_face %assigning lables in one iteration
            if minDist(ii)>minDist_single(ii)
                minDist(ii) = minDist_single(ii);
                seginfo(ii) = init_center(i);
            end
        end
    end
    if verbose
       tmp_toc = toc(iteration_tic);
       fprintf('Done finding minimum distances to centers: %.2fs\n',tmp_toc);
    end
    %update centers
    for i = 1:length(init_center)
        faceCenter_i = faceCenter(:, find(seginfo==init_center(i)));
        faceCenter_i = sum(faceCenter_i,2)/size(faceCenter_i,2);
        dist_to_centers = sum((repmat(faceCenter_i,1,num_face) - faceCenter).^2, 1);
        [~,new_center(i)] = min(dist_to_centers);
    end
    faceCenter_new = faceCenter(:, new_center);
    
    for i = 1:length(init_center)
        seginfo(seginfo==init_center(i)) = new_center(i);
    end
    
    if verbose
       tmp_toc = toc(iteration_tic)-tmp_toc;
       fprintf('Done updating centers: %.2fs\n',tmp_toc);
    end
    
    %compute the error
    err_new = sum(sum((faceCenter_new - faceCenter_init).^2,1));
    if abs(err_new-err_init)<tolerance
        done = 1;
    else
        err_init = err_new;
        init_center = new_center;
        faceCenter_init = faceCenter_new;
    end
    if verbose
       fprintf('Iteration #%d done: %.2fs\n',iteration_count, toc(iteration_tic));
    end
end

    if verbose
       fprintf('ALL Done: %.2fs\n', toc(sp_tic));
    end