3d_cascaded_seg
===============

Super-Patch Algorithm
---------------
1. Run set_up_3dseg.m to set-up the path and compile the mex function.
2. load example-model.mat in example/, which contains a model of human.
3. in super_patch, run seginfo = sp_main(face, vertex, sp_num, verbose);
   in which sp_num are number of super-patches and verbose=1 if you would
   like to manage the time.
4. to visualize the result, run:
     h = plot_mesh_segmentation(vertex,face,seginfo);

Cascaded Segmentation
---------------
TBA

Directories:
---------------
/Descriptors: Various discriptors for 3d models: HKS, ShapeDNA, etc.
/example: example files to test the algorithm
/features: features for 3d models
/helper: some helper function
/others: other functions for regular use.
/visualization: functions to plot the segmentation results
/super_patch: algorithms for super_patch calculation.