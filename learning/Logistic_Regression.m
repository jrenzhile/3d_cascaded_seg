function [theta] = Logistic_Regression(X,y,alpha,init_theta, verbose)

% [theta] = Logistic_Regression(X,y,alpha,init_theta,boundary_length_vector,verbose)
%
% Perform logistic regression on (X, y) where X is the feature vector and y
% is 0 or 1 using minFunc. 

opts.Display='off';
[m,k] = size(y); % m=#examples, k=#classes (1 means binary)
if (~exist('verbose','var'))
  verbose=0;
end

X = [ones(m, 1) X];


obj=@(w)(costFunction(w,X,y,alpha));

theta = minFunc(obj,init_theta,opts);


end
   

