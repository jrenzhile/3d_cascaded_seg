function [cluster_matrix seginfo_matrix]= ...
    cascade_main(vertex, face, segstruct, seginfo, theta_matrix, mu_matrix, sigma_matrix, tau, verbose)
% function cluster_matrix = ...
%   cascade_main(vertex, face, segstruct, seginfo, theta_matrix, mu_matrix, sigma_matrix, tau, verbose)
% 
% Perform cascade agglomeration.
% Zhile Ren <jrenzhile@gmail.com>
% Aug, 2013





steps = length(theta_matrix);
cluster_matrix = cell(1, steps);
seginfo_matrix = cell(1, steps);

for i  = 1:steps
    theta = theta_matrix{i};
    mu = mu_matrix{i};
    sigma = sigma_matrix{i};
   [newcluster_matrix seginfo segstruct] = ...
    mergeSP(vertex, face, segstruct, seginfo, ...
    theta, mu, sigma, tau, 1, verbose);
    cluster_matrix{i} = newcluster_matrix;
    seginfo_matrix{i} = seginfo;
end
