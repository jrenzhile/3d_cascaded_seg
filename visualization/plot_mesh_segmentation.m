function h = plot_mesh_segmentation(vertex,face, seginfo)

vertex = vertex';
face = face';

face_vertex_color = seginfo +1;

h = patch('vertices',vertex,'faces',face,'FaceVertexCData',face_vertex_color, 'FaceColor','flat');


set(h,'EdgeColor','none');


axis off;

axis equal;