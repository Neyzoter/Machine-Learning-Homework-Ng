function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
%一行代表一簇
K = size(centroids, 1);

% You need to return the following variables correctly.
%每个样本的下标
m = size(X,1);
idx = zeros(m , 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%


%对m组样本进行分类
%将其分在第idx(i)个簇中
for i = 1 : m
    %得到X-mu后的矩阵
    Matrix_minus = bsxfun(@minus,X(i,:) , centroids);
    %得到X和mu的距离（范数）
    norm = sum(Matrix_minus.^2,2);
    %得到norm最小值下标
    [MaxValue,idx(i)] = min(norm,[],1);    
end

% =============================================================

end

