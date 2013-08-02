modeldir = 'F:/meshsegBenchmark-1.0/data/off';
mod_to_train = load(sprintf('%s/../train.txt',modeldir));
resdir = 'F:/meshsegBenchmark-1.0/data/off';
gtdir = sprintf('%s/../seg/Benchmark',modeldir);

verbose = 1;
steps = 10;

br_tolerance = 0.02;
num_training = 100;
num_val = 30;

tot_time = tic;
for step = 1:steps
    step_start = tic;
    img2train = randperm(length(mod_to_train),num_training); % Training Image
    imgleft = setdiff(1:length(mod_to_train),img2train);
    img2val= imgleft(randperm(length(imgleft),num_val));
    
    
    
    
    fprintf(' STEP %d: %.4fsec\n',step,toc(step_start));
end

if verbose
    fprintf('Total Time is: %.fsec\n',toc(tot_time));
end