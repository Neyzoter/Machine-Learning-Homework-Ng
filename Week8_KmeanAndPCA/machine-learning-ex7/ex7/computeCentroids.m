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

%���ڼ�¼ÿ�����ж��ٸ�����
Ck = zeros(K,1);

for i = 1 : m
    %����õ�ÿ�������������
    Ck(idx(i)) = Ck(idx(i)) + 1;
    %����õ�ÿ���ص�ÿ������֮��
    centroids(idx(i),:) = centroids(idx(i),:) + X(i,:);
end


%�鿴�Ƿ��д�û�зֵ�����
%����У���ô��Ck��ֵΪ1���������0/0�����������0/1
for i = 1 : K
    if Ck(i) == 0%�����i����û�зֵ���������ô��ĸ������0
        Ck(i) = 1;
        fprintf('!!!!!!!!!!!!!!!!!!!\n\n��%d����û�зֵ�������\n\n!!!!!!!!!!!!!!!!!!!',...
            i);
    end
end

%%����ƽ��ֵ
centroids = bsxfun(@rdivide,centroids,Ck);

% =============================================================


end

