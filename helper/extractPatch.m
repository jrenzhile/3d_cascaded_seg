function [vertex, face] = extractPatch(face, seginfo, i)

% function [vertex, face] = extractPatch(face, seginfo, i)
% Extract the vertex and face of a segment of the model. 
% 
% Zhile Ren<jrenzhile@gmail.com>
% May, 2013

ind = find(seginfo ==i);

if isempty(ind)
    fprintf('such segment do not exist..\n');
    return;
end

face = face(:,ind);
uniq_seg = unique(face(:));
done_seg = zeros(size(face));

for i = 1:length(uniq_seg)
    ind_seg = find(face==uniq_seg(i));
    for ii = 1:length(ind_seg)
        if done_seg(ind_seg)==0
            done_seg(ind_seg) = 1;
            face(ind_seg) = i;
        end
    end
end

vertex = vertex(:,uniq_seg);
