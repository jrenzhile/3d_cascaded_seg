% Set up the initial features for the cascade segmentation algorithm
% Zhile Ren <jrenzhile@gmail.com>
% Aug, 2013


%%%%%%%%%% Specify the directoies/parameters  %%%%%%%%%%
modeldir = 'F:/meshsegBenchmark-1.0/data/off';
mod_to_train = load(sprintf('%s/../train.txt',modeldir));
mod_to_test = load(sprintf('%s/../test.txt',modeldir));
mod_to_val = load(sprintf('%s/../val.txt',modeldir));
mod_all = sort([mod_to_train;mod_to_test;mod_to_val]);

segdir = sprintf('%s/../seg/super_patch',modeldir);
gtdir = sprintf('%s/../seg/Benchmark',modeldir);

sp_num = 2000;
verbose = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(mod_all)
    tottime = tic;
    % Load the super-patch
    load(sprintf('%s/%d_%d.mat',segdir,mod_all(i),sp_num));
    % Normalize the model, letting every model to have same scale
    vertex = vertex/max(abs(vertex(:)));
    if min(seginfo)==0
        seginfo = seginfo+1;
    end
    snum = max(seginfo);
    % compute some helper parameters for the features
    bboxMatrix = spBoundingBox_Matrix(vertex, face, seginfo);
    [avgNormMatrix faceNorm faceArea] = spAvgNorm_Matrix(vertex, face, seginfo);
    
    unary(1).name='BoundingBox';
    unary(1).dim = 6;
    unary(1).method=@spBoundingBox; % Function to compute this feature
    unary(1).params={bboxMatrix};


    unary(2).name='avgNorm';
    unary(2).dim = 3;
    unary(2).method=@spAvgNorm;
    unary(2).params={avgNormMatrix};
        


    pairwise(1).name='mBoundingBox';
    pairwise(1).dim = 1;
    pairwise(1).method=@spBBoxIntersect; % Function to compute this feature
    pairwise(1).unary='BoundingBox';
    pairwise(1).params={};

    pairwise(2).name='cosNorm';
    pairwise(2).dim = 1;
    pairwise(2).method=@spCosNorm;
    pairwise(2).unary='avgNorm';
    pairwise(2).params={};
    
    
    % some minor modification of the unary/pairwise parameter
    [unary,pairwise]=fixFeaturePtr(unary,pairwise);
    
    % figure out the dimensions of output
    udim = cell(1,length(unary));
    d = 0;
    for u = 1:length(unary)
        udim{u} = d+1:d+unary(u).dim;
        d = d+unary(u).dim;
    end
    % The feature vector U for each super-patch
    % U(i, :) are the feature vector for patch i
    % udim{i} represent the columns of unary feature i
    U=NaN(snum,d); 
    
    for u=1:length(unary)
        utime=tic;
        for s=1:snum
                U(s,udim{u}) = ...
                    unary(u).method(s, seginfo, vertex, face,unary(u).params{:});
        end
        if (verbose)
            fprintf('Computing %s : %.4fsec\n',unary(u).name,toc(utime));
        end
    end
    
    % Get the neighbor pairs of super-patches
    spNeighbor_time = tic;
    [sp_neighbors neighbors] = sp_get_neighbors(face, seginfo);
    
    if (verbose)
            fprintf('Computing neighbors : %.4fsec\n',toc(spNeighbor_time));
    end
    
    % Now for pairwise features
    if ~isempty(sp_neighbors)
        pdim = cell(1,length(pairwise));
        d = 0;
        for p = 1:length(pairwise)
            pdim{p} = d + 1:d + pairwise(p).dim;
            d = d + pairwise(p).dim;
        end
        P = zeros(size(sp_neighbors,1),d);
        for p  = 1:length(pairwise)
            ptime = tic;
            for n = 1:size(sp_neighbors,1) % loop over neighboring pairs
                s1=sp_neighbors(n,1);
                s2=sp_neighbors(n,2);
                if (~isempty(pairwise(p).unary)) % function of unary features
                    f1 = U(s1,[udim{pairwise(p).unary}]);
                    f2 = U(s2,[udim{pairwise(p).unary}]);
                    P(n,pdim{p}) = pairwise(p).method(f1,f2,pairwise(p).params{:}); % pairwise features are computed in this format
                else 
                    P(n,pdim{p}) = pairwise(p).method(pairwise(p).params{:}); % standalone pairwise features are computed in this format
                end
            end
            if verbose 
                fprintf('%s : %.4fsec\n',pairwise(p).name,toc(ptime));
            end
        end
    else
        pdim = [];
        P = [];
    end
    
    % Store them all in a structure
    segstruct.U=U;
    segstruct.udim=udim;
    segstruct.P=P;
    segstruct.pdim=pdim;
    segstruct.unary=unary;
    segstruct.pairwise=pairwise;
    segstruct.sp_neighbors=sp_neighbors; 
    segstruct.neighbors = neighbors; % Notice that those two neighbors are totally different!
    segstruct.snum = snum; 
    segstruct.faceNorm = faceNorm; 
    segstruct.faceArea = faceArea;
    segstruct.bboxMatrix = bboxMatrix; % Later we'll need those
    
    % Store each ground truth segmentation in a cell structure
    gt_models = rdir(sprintf('%s\\%d',gtdir, mod_all(i)));
    gt_cell = cell(1, length(gt_models));
    for j = 1:length(gt_cell)
        gtinfo = load(gt_models(j).name);
        if min(gtinfo)==0
            gtinfo = gtinfo+1;
        end
        gt_cell{j} = gtinfo;
    end
    
    total_time=toc(tottime);
    if (verbose > 0)
      fprintf('Processing %d, Total time %.4fsec\n\n',mod_all(i),total_time);
    end
    
    save(sprintf('%s/cascade_init/%d',modeldir,mod_all(i)), ...
        'segstruct','vertex','face','seginfo','gt_cell');
end