% sp_all.m
% get the super patch of all the models
%
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013


modeldir = '/home-nfs/zhile/nlpr/segmentation/MeshsegBenchmark-1.0/data/off';
resdir = '/home-nfs/zhile/nlpr/segmentation/MeshsegBenchmark-1.0/data/seg/super_patch';

sp_num = 2000;
verbose = 0;

cd(modeldir);
mod_to_proc = dir();
mod_to_proc = mod_to_proc(3:end);


for i=1:length(mod_to_proc)
  [~,mod_name,~] = fileparts(mod_to_proc(i).name);
  if exist(sprintf('%s/%s_%d.mat',resdir,mod_name,sp_num),'file')==2
      fprintf('%d Already Done\n', i);
      continue;
  end
  time_spent_i = tic;
  [vertex,face] = read_off(sprintf('%s',mod_to_proc(i).name));

  seginfo = sp_main(face, vertex,sp_num , verbose); 
  
  save(sprintf('%s/%s_%d.mat',resdir,mod_name,sp_num),'seginfo','vertex','face');
  fprintf('Processing %.2f%%, time spent: %.2fs\n',i/length(mod_to_proc)*100, toc(time_spent_i));
end

