function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

%用于记录每个簇有多少个样本
Ck = zeros(K,1);

for i = 1 : m
    %计算得到每个组的样本个数
    Ck(idx(i)) = Ck(idx(i)) + 1;
    %计算得到每个簇的每个特征之和
    centroids(idx(i),:) = centroids(idx(i),:) + X(i,:);
end


%查看是否有簇没有分到样本
%如果有，那么把Ck赋值为1，不会造成0/0的情况，而是0/1
for i = 1 : K
    if Ck(i) == 0%如果第i个簇没有分到样本，那么分母不能是0
        Ck(i) = 1;
        fprintf('!!!!!!!!!!!!!!!!!!!\n\n第%d个簇没有分到样本！\n\n!!!!!!!!!!!!!!!!!!!',...
            i);
    end
end

%%计算平均值
centroids = bsxfun(@rdivide,centroids,Ck);

% =============================================================


end

