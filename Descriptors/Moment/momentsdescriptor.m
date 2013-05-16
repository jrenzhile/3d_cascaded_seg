function [f] = momentsdescriptor(vertices, faces, norder)
% calculate the moments descriptor for a given shape
% input vertices: 3*n; faces: 3*n
% for mesh, the moment should be calculated as 
% m_{pqr} = \sum_{t\in T}(\bar{x}_t^1)^p(\bar{x}_t^2)^q(\bar{x}_t^3)^r a_t,
% where a_t is the t-th face's area and \bar{x}_t is the central of t-th
% face

dim = size(vertices, 1);
% calculate the central of each triangle face
vt = (vertices(:, faces(1, :)) + vertices(:, faces(2, :)) + vertices(:, faces(3, :)))/3;
% calculate the area of each face
area = calcFaceArea(vertices, faces);

area = area/sum(area);

n = size(vt, 2);

% first-order moments
firstmoment = sum(vt.*repmat(area, 3, 1), 2);

% second-order moments
secondmoment = zeros(3);
for i=1:3
    for j=1:3
        secondmoment(i, j) = sum((vt(i, :).*vt(j, :)).*area);
    end
end

% orienting the shape 
[V, D] = eig(secondmoment);
[tmp, idx] = sort(abs(diag(D)), 'descend');
V = V(:, idx);
vt = V' * (vt - repmat(firstmoment, 1, n));
signs = diag(D)./abs(diag(D));
vt = vt.*repmat(signs, 1, size(vt, 2));

% bounding the shape into unit bounding box
scale = 1/max(max(vt, [], 2)-min(vt, [], 2));

vt = vt * scale;

% vertices(i, :)^n
X1 = zeros(norder+1, size(vt, 2));
X1(1, :) = ones(1, size(vt, 2));
X2 = X1;
X3 = X1;
for i = 1:norder
    X1(i+1, :) = X1(i, :).*vt(1, :);
    X2(i+1, :) = X2(i, :).*vt(2, :);
    X3(i+1, :) = X3(i, :).*vt(3, :);
end
X3 = X3.*repmat(area, norder+1, 1);

f=[];
for i=0:norder
    for j=0:norder-i
        for k=0:norder-i-j
            f = [f; sum(X1(i+1, :).*X2(j+1, :).*X3(k+1, :))];
        end
    end
end



