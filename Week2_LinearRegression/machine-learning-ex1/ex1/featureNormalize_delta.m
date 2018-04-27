function [X_norm, mu, delta] = featureNormalize_delta(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.
%   delta:max-min
% You need to set these values correctly
X_norm = X;
mu = zeros(1, size(X, 2));%列数

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       

mu = mean(X);%每列相加除以样本个数，平均值
delta = max(X,[],1) - min(X,[],1);

%%采用max-min
X_norm = ( X - ones(size(X,1),1) * mu ) ./ delta;%特征缩放

% ============================================================

end
