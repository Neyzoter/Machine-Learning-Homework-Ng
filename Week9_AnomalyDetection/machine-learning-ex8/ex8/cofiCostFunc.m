function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
% params中包含了前面num_movies*num_features行：特征X，电影数*特征数
% num_movies*num_features+1至end行：参数theta，用户数*特征数
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

% 计算出偏差，而后用R将已经打分值提取出来
% X ：电影数*特征数
% Theta：用户数*特征数
% Y：电影数*用户数
J = 0.5 * sum(sum(((X*Theta' - Y).^2).* R)) +...
    0.5 * lambda * sum(sum(Theta.^2)) + ...
    0.5 * lambda * sum(sum(X.^2)) ;

% 得到关于X的偏导
X_grad = (X * Theta' - Y).* R * Theta + lambda * X;
% 得到关于theta的偏导
Theta_grad = ((X * Theta' - Y).* R)' * X + lambda * Theta;

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
