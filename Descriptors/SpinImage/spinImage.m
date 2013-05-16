function [SI, basispts] = spinImage(vertices, faces, nbasis, scaleR, SAMPLE)
% spin image extractor 
% input: vertices: vertices with format [3 x nv]
%        faces:    triangle connection with format [3 x nf]
%        nbasis:   number of basis points, or number of SIs for each shape
%        scaleR:   the support range of spinning window
%        SAMPLE:   number of point samples to approximate the shape
% output: SI:      the spin image descriptors with format nbasis x (WRESOLUTION*HRESOLUTION)
%         basispts:basis points

WRESOLUTION = 15;
HRESOLUTION = 15;

if nargin < 4
    scaleR = 0.4;
end

if nargin < 5
    SAMPLE = 10000;
end

% calculate the bounding sphere radius
vcenter = mean(vertices, 2);
vt = vertices - repmat(vcenter, 1, size(vertices, 2));
vt = sum(vt.^2);
objectradius =  sqrt(max(vt));


disp('...Dense sampling on the mesh...');
% calculate the face area
area = calcFaceArea(vertices, faces);
totalarea = sum(area);
samplearea = rand(SAMPLE, 1) * totalarea;
% sample the face according to the area
sampleface = sampleFace(area', samplearea);
sfaces = faces(:, sampleface);
% sample points on the mesh
r = rand(3, SAMPLE);
r = r./repmat(sum(r), 3, 1);
sampts = sampleonmesh(vertices, sfaces, r);  % create Monte-Carlo sample


SI = zeros(nbasis, WRESOLUTION * HRESOLUTION);
imageHeight = 2*objectradius*scaleR;
imageWidth = objectradius*scaleR;
stepW = imageWidth / WRESOLUTION;
stepH = imageHeight / HRESOLUTION;


disp('...Calculating spin images...');
basispts = sampts(:, 1:nbasis);
basisfaces = sfaces(:, 1:nbasis);
for i = 1:nbasis
    bpts = basispts(:, i);
    bptdis = sqrt(sum((sampts - repmat(bpts, 1, SAMPLE)).^2));  % distance between samples to the basis point
    f = basisfaces(:, i);
    normal = normc(cross(vertices(:, f(2))-vertices(:, f(1)), vertices(:, f(3))-vertices(:, f(1))));
    
    elevation = normal' * (sampts - repmat(bpts, 1, SAMPLE));
    radis = sqrt(bptdis.^2 - elevation.^2);
    
    inimage = (abs(elevation) < imageHeight/2) & (radis < imageWidth);  % point samples inside the supporting range
    elevation = elevation(inimage)/stepH + HRESOLUTION/2;
    radis = radis(inimage)/stepW;
    
    basispts(:, i) = bpts;
    SI(i, :) = countimage(elevation, radis, HRESOLUTION, WRESOLUTION);
end

end
