3d_cascaded_seg
===============

Demo: Super-Patch Algorithm
---------------
1. Run set_up_3dseg.m to set-up the path and compile the mex function.
2. Load example-model.mat in example/, which contains a model of human.
3. In super_patch, run seginfo = sp_main(face, vertex, sp_num, verbose);
   in which sp_num are number of super-patches and verbose=1 if you would
   like to manage the time.
4. To visualize the result, run:
     h = plot_mesh_segmentation(vertex,face,seginfo);
5. To see the training steps of this algorithm, please refer to sp_train.m

Demo: Cascaded Segmentation
---------------
1. load a model in meshsegBenchmark-1.0/data/seg/off/cascade_init
2. load learned_data.mat
3. tau = 0.5; verbose = 1;
4. run [cluster_matrix seginfo_matrix]= ...
    cascade_main(vertex, face, segstruct, seginfo, theta_matrix, mu_matrix, sigma_matrix, tau, verbose);
5. for i = 1:30
    h = plot_mesh_segmentation(vertex,face,seginfo_matrix{i})
   end



Directories:
---------------
* /Descriptors: Various discriptors for 3d models: HKS, ShapeDNA, etc.
* /example: example files to test the algorithm
* /features: features for 3d models
* /helper: some helper function
* /others: other functions for regular use.
* /visualization: functions to plot the segmentation results
* /super_patch: algorithms for super_patch calculation.
* /cascade: functions to train/run the cascade agglomeration algorithm


Explanation of the  data structures:
---------------

* We adapted a matlab toolbox called "toolbox_graph" in this project, 
which provides an convenient way to load/operate on 3d models in off format.

* After reading the model using [vertex,face] = read_off(filename);
 -  'vertex' is a 'n_vertice x 3' array specifying the coodinates of the vertices.
 -   'face' is a 'n_face x 3' array, where face(:, i) specifies the vertice number of face i
* segmentations are stored in an one dimentional array, such as seginfo in the demo of super-patch algorithm, and seginfo(i) is the segmentation label of face i. If seginfo(i)==seginfo(j), it means that they are from the same segment.