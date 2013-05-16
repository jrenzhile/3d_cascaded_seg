function area = calcFaceArea(pts, faces)
% calc the area of each face
% S = \sqrt{(|AB||AC|)^2 - (AB\cdot AC)^2}
% S = \sqrt{p(p-a)(p-b)(p-c)} p=(a+b+c)/2

v1 = pts(:, faces(1, :)) - pts(:, faces(2, :));
v2 = pts(:, faces(3, :)) - pts(:, faces(2, :));
% v3 = pts(:, faces(3, :)) - pts(:, faces(1, :));
% 
% a = sum(v1.*v1);
% b = sum(v2.*v2);
% c = sum(v3.*v3);
% p = (a+b+c)/2;
% 
% area = sqrt(p.*(p-a).*(p-b).*(p-c));

area = sqrt(dot(v1, v1).*dot(v2, v2) - dot(v1, v2).^2);

end