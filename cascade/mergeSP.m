function [cluster_matrix seginfo segstruct] = ...
    mergeSP(vertex, face, segstruct, seginfo, ...
    theta, mu, sigma, tau, update, verbose)

cluster_time = tic;
sp_num = max(seginfo);

PgMatrix  = zeros(sp_num ,sp_num);
Ps = bsxfun(@rdivide,bsxfun(@minus,segstruct.P,mu),sigma);
Ps = [ones(size(Ps,1),1) Ps];

Pg_hat = sigmoid(Ps*theta);
PgMatrix(sub2ind(size(PgMatrix),segstruct.sp_neighbors(:,1), ...
                 segstruct.sp_neighbors(:,2)))=Pg_hat;


iterations = 0;
max_iter = length(unique(seginfo));
cluster_matrix = zeros(sp_num,3); 

while iterations < max_iter
    if length(unique(seginfo)) <= 2
        break; % nothing to merge
    end
    [maxpg,maxind]=max(PgMatrix(:));
    if (maxpg < tau)
        break; % no pair with Pg >= tau
    end
    [s1,s2]=ind2sub(size(PgMatrix),maxind);
    iterations = iterations +1;
    
    if (any(cluster_matrix(:,3)==s2))
        keyboard;
    end
    
	if verbose > 0
        fprintf('%d:  %d + %d  %.4f\n',iterations,s1,s2,maxpg);
	end
    
    seginfo(seginfo==s2) = s1;
    PgMatrix(s2,:)=0;
	PgMatrix(:,s2)=0;
    PgMatrix(s1,:)=0;
    PgMatrix(:,s1)=0;
    cluster_matrix(iterations,:) = [maxpg s1 s2];
end


if update
    segstruct = updateFeatures(vertex, face,seginfo, segstruct,verbose);
end