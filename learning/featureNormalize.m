function [X_norm, mu, sigma] = featureNormalize(X)
% function [X_norm, mu, sigma] = featureNormalize(X)
% Return a normalized version of X where
% the mean value of each feature is 0 and the standard deviation
% is 1.


mu = mean(X);
sigma = std(X);
sigma(sigma==0)=1; % GS added to avoid NaN
X_norm = bsxfun(@rdivide,bsxfun(@minus,X,mu),sigma);
%X_norm = (X-repmat(mu,size(X,1),1))./repmat(sigma,size(X,1),1);


