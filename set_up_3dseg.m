% addpath(genpath('C:\Users\luvegood\Documents\MATLAB\toolbox_graph'));  addpath(genpath(fullfile(pwd,'../toolbox_graph')));
addpath(genpath(fullfile(pwd,'features')));
addpath(genpath(fullfile(pwd,'super_patch')));
addpath(genpath(fullfile(pwd,'visualization')));
addpath(genpath(fullfile(pwd,'learning')));
addpath(genpath(fullfile(pwd,'helper')));
addpath(genpath(fullfile(pwd,'cascade_seg')));
addpath(genpath(fullfile(pwd,'measures')));
addpath(genpath(fullfile(pwd,'Descriptors')));
% addpath(genpath('C:\Users\luvegood\Documents\MATLAB\minFunc\minFunc'));
fprintf('Path set up done!\n');

cd features/mex/
mex compFaceNorm.cpp
mex getNeighbor.cpp
cd ..
cd ..
cd super_patch/
mex spfa_c.cpp
cd ..

fprintf('Mex file compiled!\n');