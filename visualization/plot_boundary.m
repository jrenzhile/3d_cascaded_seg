function h = plot_boundary(vertex, face, seginfo, boundary_color, mod_color)

% h = plot_boundary(edges, face, vertex, boundary_color, mod_color);
%
% Plot the boundary of the segmentation of the model.
% Please specify the color for boundaries and for the model itself,
% otherwise boundary_color = 'r', mod_color = 'g'
% 
% Zhile Ren <jrenzhile@gmail.com>
% July, 2013



if nargin<5
    boundary_color = 'r';
    mod_color = 'g';
end

edges = extractBoundary(vertex, face, seginfo);


h = patch('vertices',vertex','faces',face','FaceColor',mod_color);
set(h,'EdgeColor','none');
hold on;

x = [vertex(1,edges(1,:)); vertex(1,edges(2,:))];
y = [vertex(2,edges(1,:)); vertex(2,edges(2,:))];
z = [vertex(3,edges(1,:)); vertex(3,edges(2,:))];

h = line(x,y,z, 'color', boundary_color);    

axis off;
axis image;

end