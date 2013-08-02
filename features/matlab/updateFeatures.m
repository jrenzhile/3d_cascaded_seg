function newsegstruct = ...
    updateFeatures(vertex, face,seginfo, segstruct, verbose)

% function newsegstruct = updateFeatures(vertex, face,seginfo, segstruct, verbose)
% Update the features.
%
% Zhile Ren<jrenzhile@gmail.com>
% Aug, 2013




tot_time = tic;
if verbose
    fprintf('Updating Features\n');
end
newsegstruct=segstruct;

unary=segstruct.unary;
pairwise=segstruct.pairwise;
udim=segstruct.udim;
pdim=segstruct.pdim;
neighbors = segstruct.neighbors;

bboxMatrix = spBoundingBox_Matrix(vertex, face, seginfo);
[avgNormMatrix,~,~] = ...
    spAvgNorm_Matrix(vertex, face, seginfo, segstruct.faceNorm, segstruct.faceArea);

unary(1).params={bboxMatrix};
unary(2).params={avgNormMatrix};

uniq_seg  = unique(seginfo);

for u=1:length(unary)
    utime=tic;
    for s=1:length(uniq_seg)
            U(uniq_seg(s),udim{u}) = ...
                unary(u).method(uniq_seg(s), seginfo, vertex, face,unary(u).params{:});
    end
    if (verbose)
        fprintf('Computing %s : %.4fsec\n',unary(u).name,toc(utime));
    end
end
spNeighbor_time = tic;
sp_neighbors = sp_get_neighbors(face, seginfo,neighbors);
if (verbose)
        fprintf('Computing neighbors : %.4fsec\n',toc(spNeighbor_time));
end


if ~isempty(sp_neighbors)
     pdim = cell(1,length(pairwise));
    d = 0;
    for p = 1:length(pairwise)
        pdim{p} = d + 1:d + pairwise(p).dim;
        d = d + pairwise(p).dim;
    end
    P = zeros(size(sp_neighbors,1),d);
    for p  = 1:length(pairwise)
        ptime = tic;
        for n = 1:size(sp_neighbors,1) % loop over neighboring pairs
            s1=sp_neighbors(n,1);
            s2=sp_neighbors(n,2);
            if (~isempty(pairwise(p).unary)) % function of unary features
                f1 = U(s1,[udim{pairwise(p).unary}]);
                f2 = U(s2,[udim{pairwise(p).unary}]);
                P(n,pdim{p}) = pairwise(p).method(f1,f2,pairwise(p).params{:});
            else 
                P(n,pdim{p}) = pairwise(p).method(pairwise(p).params{:});
            end
        end
        if (verbose > 0)
            fprintf('%s : %.4fsec\n',pairwise(p).name,toc(ptime));
        end
    end
else
    pdim = [];
    P = [];
end



newsegstruct.U = U;
newsegstruct.P = P;
newsegstruct.unary=unary;
newsegstruct.pairwise=pairwise;
newsegstruct.sp_neighbors = sp_neighbors;

if (verbose > 0)
      fprintf('Done Updating features, total time %.4fsec\n\n',toc(tot_time));
end