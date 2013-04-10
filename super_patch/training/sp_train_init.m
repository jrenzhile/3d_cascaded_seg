% sp_train_init.m
% training data initialization for super-patch algorithm. 
%
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013


modeldir = 'c:/Users/luvegood/Desktop/NLPR/segmentation/MeshsegBenchmark-1.0/data/off';
mod_to_train = load(sprintf('%s/../train.txt',modeldir));
gtdir ='c:/Users/luvegood/Desktop/NLPR/segmentation/MeshsegBenchmark-1.0/data/seg/Benchmark';

X = [];
y = [];



for i=1:length(mod_to_train)
time_spent_i = tic;
  [vertex,face] = read_off(sprintf('%s/%d.off',modeldir,mod_to_train(i)));

  faceNorm = compFaceNorm(vertex,face); %c function
  neighbors = getNeighbor(face); %c function
  phyDist = computePhyDist(vertex,face,neighbors); %matlab function
  dihedralAngle = computeDihedralAngle(faceNorm,neighbors);%matlab function
  
  num_gt = length(dir(sprintf('%s/%d/',gtdir,mod_to_train(i)))) - 2;
  gtDist = zeros(size(neighbors));
  for j = 1:num_gt
    seginfo = load(sprintf('%s/%d/%d_%d.seg',gtdir,mod_to_train(i),mod_to_train(i),j-1));
    gtDist_j = computeGroundTruthDistance(seginfo,neighbors);
    gtDist = gtDist+gtDist_j;
  end
  gtDist = gtDist/num_gt;
  
  [m,n] = size(neighbors);
  for jj = 1:n
      for ii = 1:m
          if (neighbors(ii,jj)>jj)
              X = [X;1-dihedralAngle(ii,jj)^2 phyDist(ii,jj)];
              y = [y;gtDist(ii,jj)];
          end
      end
  end
   
  fprintf('Processing %.2f%%, time spent: %.2fs\n',i/length(mod_to_train)*100, toc(time_spent_i));
end
