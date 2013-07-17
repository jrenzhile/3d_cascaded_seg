function ri = rand_index(seginfo,gtseg,n_count)

% function ri = rand_index(suppix1,suppix2)
% Given two segmentation maps, compute the random index score between them.
% Random Index measures the probability that an arbitrary 
% pair of samples have consistent labels in the two partitions
%
% Original Code by : John Wright <jnwright@uiuc.edu>
% Revised by : Zhile Ren <jrenzhile@gmail.com>
% Sept 2012


if ~exist('n_count','var')
    seg_num1=length(unique(seginfo));
    seg_num2=length(unique(gtseg));
    if min(seginfo)==0
        seginfo = seginfo+1;
    end
    
    if min(gtseg)==0
        gtseg = gtseg+1;
    end
    
    % compute the count matrix
    n_count=zeros(seg_num1,seg_num2);

    for i=1:size(seginfo,1)
        for j=1:size(seginfo,2)
            u=seginfo(i,j);
            v=gtseg(i,j);
            n_count(u,v)=n_count(u,v)+1;
        end
    end
end


N = sum(n_count(:));
n_u = sum(n_count,2);
n_v = sum(n_count,1);
N_choose_2 = N * (N - 1)/2;
ri = 1 - ( sum(n_u .* n_u)/2 + sum(n_v .* n_v)/2 - sum(sum(n_count.*n_count)) )/N_choose_2;
