% function ri = randindex(seginfo,gtinfo)
% Note: A C++ function
% Given two segmentation maps, compute the random index score between them.
% Random Index measures the probability that an arbitrary 
% pair of samples have consistent labels in the two partitions
%
% Original Code by : John Wright <jnwright@uiuc.edu>
% Revised by : Zhile Ren <jrenzhile@gmail.com>
% Sept 2012