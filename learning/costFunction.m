function [J, grad] = costFunction(theta, X, y, alpha_weight)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y,alpha) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.
   

m = length(y); % number of training examples

J = sum((-log(sigmoid(X*theta)) .* y - alpha_weight * (1-y) .* log(1-sigmoid(X*theta))));
J=J/m;

grad = (alpha_weight*sigmoid(X*theta)-y-(alpha_weight-1)*sigmoid(X*theta).*y);
grad = grad' * X;
grad = grad(:)/m;


