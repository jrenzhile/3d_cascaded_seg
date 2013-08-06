modeldir = 'F:/meshsegBenchmark-1.0/data/off';
gtdir = sprintf('F:/meshsegBenchmark-1.0/data/seg/Benchmark');
featuredir = sprintf('%s/system1',modeldir);
mod_to_train = load(sprintf('%s/../train.txt',modeldir));
mod_to_test = load(sprintf('%s/../test.txt',modeldir));
mod_to_val = load(sprintf('%s/../val.txt',modeldir));
mod_all = sort([mod_to_train;mod_to_test;mod_to_val]);

verbose = 1;
steps = 30;

br_tolerance = 0.02;
num_training = 100;
num_val = 30;
tau = 0.5;



tot_time = tic;

infoAll = cell(1,max(mod_to_train));
for i = 1:length(mod_to_train)
    seg = load(sprintf('%s/%d.mat', featuredir, mod_to_train(i)));
    infoAll{mod_to_train(i)} = seg;
    infoAll{mod_to_train(i)}.cluster_matrix = [];
    fprintf('Done Collecting Info for %d\n',i);
end


theta_matrix = cell(1, steps);
mu_matrix =  cell(1, steps);
sigma_matrix =  cell(1, steps);

for step = 11:steps
    step_start = tic;
    img2train = randperm(length(mod_to_train),num_training); % Training Image
    imgleft = setdiff(1:length(mod_to_train),img2train);
    img2val= imgleft(randperm(length(imgleft),num_val));
    
    if step<3
        truc_pct = 0.005;
    else
        truc_pct = 0.01;
    end
    
    [X y] = ...
        construct_feature_vector(infoAll, mod_to_train(img2train),truc_pct, verbose);
    X(isnan(X)) = 0;
    initial_theta = zeros(size(X, 2)+1, 1);
    [X,mu,sigma]=featureNormalize(X);
    alpha = 1;
    [theta] = Logistic_Regression(X,y,alpha,initial_theta, verbose);
    theta_matrix{step} = theta;
    mu_matrix{step} =  mu;
    sigma_matrix{step} = sigma;
    
     save('learned_data','theta_matrix', 'mu_matrix', 'sigma_matrix');
    
     for i = 1:length(mod_to_train)
         merge_time = tic;
         fprintf('Merging Model %d, Step %d\n', i, step);
       seginfo = infoAll{mod_to_train(i)}.seginfo;
       segstruct = infoAll{mod_to_train(i)}.segstruct;
       vertex = infoAll{mod_to_train(i)}.vertex;
       face = infoAll{mod_to_train(i)}.face;
       update = 1;
       [cluster_matrix seginfo segstruct] = ...
    mergeSP(vertex, face, segstruct, seginfo, ...
    theta, mu, sigma, tau, update, 0);         
        infoAll{mod_to_train(i)}.seginfo = seginfo;
        infoAll{mod_to_train(i)}.segstruct  = segstruct;
        infoAll{mod_to_train(i)}.cluster_matrix = ...
            [infoAll{mod_to_train(i)}.cluster_matrix; cluster_matrix];
         fprintf('Done Merging Model %d, %.2fs\n', i, toc(merge_time));
     end

     fprintf(' STEP %d: %.4fsec\n',step,toc(step_start));
     
end

if verbose
    fprintf('Total Time is: %.fsec\n',toc(tot_time));
end


