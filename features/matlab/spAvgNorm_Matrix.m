function [avgNormMatrix faceNorm faceArea]= ...
    spAvgNorm_Matrix(vertex, face, seginfo,faceNorm, faceArea)

% function [avgNormMatrix faceNorm faceArea] = spAvgNorm_Matrix(vertex, face, seginfo)
% finding the average norm for each patch of the model
% where each avgNorm = sum(NormOfEachMesh*ProportionOfArea)
% and size(avgNormMatrix) =  3 *#segs
% 
% Zhile Ren<jrenzhile@gmail.com>
% July, 2013

if ~exist('faceNorm','var');
    faceNorm = compFaceNorm(vertex,face);
end

if ~exist('faceArea', 'var')
    faceArea = computeFaceArea(vertex, face);
end

faceNorm = normc(faceNorm);

if min(seginfo)==0
    seginfo = seginfo+1;
end

avgNormMatrix = zeros(3, max(seginfo));
uniq_ind = unique(seginfo);

for i = 1:length(uniq_ind)
    face_ind = find(seginfo==uniq_ind(i));
    face_area_i = faceArea(face_ind);
    face_area_i_proportion = face_area_i/sum(face_area_i);
    face_norm_i = faceNorm(:,face_ind);
    avgNormMatrix(:,uniq_ind(i)) = face_norm_i * face_area_i_proportion;
end