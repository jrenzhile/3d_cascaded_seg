function faceNorm = computeFaceNorm(vertex, face, verbose)

if(nargin<3)
    verbose = 0;
end

start_tic = tic;


nFace = size(face,2);
faceNorm = zeros(3, nFace);

for i = 1:nFace
    indVertex = face(:,i);
    v_1 = vertex(:,indVertex(2))-vertex(:,indVertex(1));
    v_2 = vertex(:,indVertex(3))-vertex(:,indVertex(1));
    faceNorm(:,i)= cross(v_1,v_2);    
end


stop_tic = toc(start_tic);

if(verbose)
    fprintf('Time Spent on Computing Face Norm: %.2fs\n',stop_tic);
end