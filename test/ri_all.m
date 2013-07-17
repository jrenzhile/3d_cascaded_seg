% Running rand_index on all the models...

%% Core_extra Single segmentation
segdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\coreExtra';
gtdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\Benchmark';

models_to_test = rdir(segdir);

ri_all = zeros(1, length(models_to_test));

for i = 1:length(models_to_test)
    [~, name, ~] = fileparts(models_to_test(i).name);
    gt_models = rdir(fullfile(gtdir, name));
    ri_single = zeros(1, length(gt_models));
    
    seginfo = load(models_to_test(i).name);
    
    for j = 1:length(gt_models)
        gtseg = load(gt_models(j).name);
        ri_single(j) = randindex(seginfo,gtseg);
    end
    ri_all(i) = mean(ri_single);
    fprintf('Done %.2f%%\n',i/length(models_to_test)*100);
end

% 1-mean(ri_all) = 0.2108

%% RandCuts
segdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\RandCuts';
gtdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\Benchmark';

models_to_test = rdir(segdir);

ri_all = zeros(1, length(models_to_test));


for i = 1:length(models_to_test)
    [~, name, ~] = fileparts(models_to_test(i).name);
    gt_models = rdir(fullfile(gtdir, name));
    seg_models = rdir(fullfile(segdir, name));
    ri_single = zeros(length(seg_models), length(gt_models));
    
    for ii = 1:length(seg_models)
        seginfo = load(seg_models(ii).name);
        for j = 1:length(gt_models)
            gtseg = load(gt_models(j).name);
            ri_single(ii,j) = randindex(seginfo,gtseg);
        end
        
    end
    ri_single = mean(ri_single,2);
    ri_all(i) = max(ri_single);
    fprintf('Done %.2f%%\n',i/length(models_to_test)*100);
end

% 1-mean(ri_all) = 0.1319


%% NormCuts
segdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\NormCuts';
gtdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\Benchmark';

models_to_test = rdir(segdir);

ri_all = zeros(1, length(models_to_test));


for i = 1:length(models_to_test)
    [~, name, ~] = fileparts(models_to_test(i).name);
    gt_models = rdir(fullfile(gtdir, name));
    seg_models = rdir(fullfile(segdir, name));
    ri_single = zeros(length(seg_models), length(gt_models));
    
    for ii = 1:length(seg_models)
        seginfo = load(seg_models(ii).name);
        for j = 1:length(gt_models)
            gtseg = load(gt_models(j).name);
            ri_single(ii,j) = randindex(seginfo,gtseg);
        end
        
    end
    ri_single = mean(ri_single,2);
    ri_all(i) = max(ri_single);
    fprintf('Done %.2f%%\n',i/length(models_to_test)*100);
end

% 1-mean(ri_all) = 0.1421

%% FitPrim
segdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\FitPrim';
gtdir = 'c:\Users\luvegood\Desktop\NLPR\segmentation\MeshsegBenchmark-1.0\data\seg\Benchmark';

models_to_test = rdir(segdir);

ri_all = zeros(1, length(models_to_test));


for i = 1:length(models_to_test)
    [~, name, ~] = fileparts(models_to_test(i).name);
    gt_models = rdir(fullfile(gtdir, name));
    seg_models = rdir(fullfile(segdir, name));
    ri_single = zeros(length(seg_models), length(gt_models));
    
    for ii = 1:length(seg_models)
        seginfo = load(seg_models(ii).name);
        for j = 1:length(gt_models)
            gtseg = load(gt_models(j).name);
            ri_single(ii,j) = randindex(seginfo,gtseg);
        end
        
    end
    ri_single = mean(ri_single,2);
    ri_all(i) = max(ri_single);
    fprintf('Done %.2f%%\n',i/length(models_to_test)*100);
end

% 1-mean(ri_all) = 0.1854
