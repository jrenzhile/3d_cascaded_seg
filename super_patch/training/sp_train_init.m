% cluster_initilization_ucm.m:
% A script which provides a setup for the function computeSegfetures.m
% which computes the feature vectors of any image segmentation.
% unary stores the unary feautures of each segment, and pairwise stores
% the pairwise features between neighboring segments. Finally it will
% store the feature information in the directory "resdir".

modeldir = 'c:/Users/luvegood/Desktop/NLPR/segmentation/MeshsegBenchmark-1.0/data/off';
mod_to_train = load(sprintf('%s/../train.txt',modeldir));
gtdir ='c:/Users/luvegood/Desktop/NLPR/segmentation/MeshsegBenchmark-1.0/data/seg/Benchmark';

verbose = 1;


for i=1:length(mod_to_train)
    
  [vertex,face] = read_off(sprintf('%s/%d.off',modeldir,mod_to_train(i)));
  faceNorm = compFaceNorm(vertex,face);
  neighbors = getNeighbors(face);
  phyDist = computePhyDist(vertex,face,neighbor);
  
  fprintf('Saved %d\n',i);
end


  
