function h = plot_mesh_segmentation(modeldir, segdir)

[vertex,face] = read_off(modeldir);

vertex = vertex';
face = face';

face_vertex_color = load(segdir);
if(min(face_vertex_color(:)))==0
    face_vertex_color = face_vertex_color+1;
end

h = patch('vertices',vertex,'faces',face,'FaceVertexCData',face_vertex_color, 'FaceColor','flat');


set(h,'EdgeColor','none');


axis off;

axis equal;