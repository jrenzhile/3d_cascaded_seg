modeldir = 'F:/meshsegBenchmark-1.0/data/off';
mod_to_train = load(sprintf('%s/../train.txt',modeldir));

segdir = sprintf('%s/../seg/super_patch',modeldir);
gtdir = sprintf('%s/../seg/Benchmark',modeldir);

verbose = 1;

