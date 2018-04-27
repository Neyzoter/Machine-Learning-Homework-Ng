function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
[m n] = size(X);

% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



%==说明==：激励a除了输出层，均包括偏置1


%在X前加上5000*1的一列1，输入层为a1
a1 = [ones(m,1) X];

%X：5000样本*401个特征
%Theta1：25个输出*401个输入
%z2：隐藏层没有激励时的输入z2
z2 = a1 * Theta1';
a2 = sigmoid(z2);%第一层输出5000个样本（5000行），25个激励（列）
a2 = [ones(m,1) a2];%加入偏置1

%Theta2：10个输出*26个输入
%a3：5000样本*10输出
%z2：输出层没有激励时的输入z3
z3 = a2 * Theta2';
a3 = sigmoid(z3);

%计算log(h)和log(1-h)
logh = log(a3);
log1_h = log(1-a3);
%用于y == Ref得到5000个样本*10分类输出

%1-num_labels行向量,这里如果用10的话，对于不同的分类不适用
%Ref：样本数*分类输出
%如：Ref = [1 0 0 ;0 1 0;0 1 0]
%表示第一个样本是分类1，第二三个样本是分类2
Ref = 1:num_labels;
Ref = (y == Ref);
%% 计算J
% % 方法1（即一个一个加）
% for i = 1 : m
%     J = J - 1 / m * ( Ref(i,:) * (logh(i,:))' + ...
%         (1 - Ref(i,:)) * (log1_h(i,:))');
% end
% %正则化
% J =  J + 0.5 * lambda / m * (sum(sum(Theta1(:,2:end).^2)) + ...
%     sum(sum(Theta2(:,2:end).^2)));

%方法2，向量化计算
%注意正则化时，不加入偏置部分的参数theta
J = - 1 / m * sum(sum(( Ref .* logh + (1 - Ref) .* log1_h))) + ...
    0.5 * lambda / m * (sum(sum(Theta1(:,2:end).^2)) + ...
    sum(sum(Theta2(:,2:end).^2)));

%% ===反向传播=====
%使得Delta和Theta的矩阵一样规格
Delta2 = zeros(num_labels,hidden_layer_size+1);
Delta1 = zeros(hidden_layer_size,input_layer_size+1);
%对m个数据进行遍历
for i = 1:m
    %输出层
    %Ref：m*num_labels，即为y转化为向量形式
    %delta3:1*num_labels
    delta3 = a3(i,:) - Ref(i,:);

    %隐藏层
    %Theta2：10*26
    %delta3:1*num_labels
    %a3：m*hidden_layer_size，不包括偏置1
    %a2：1*26，第一个为偏置1
    %delta2：1*26   
    
    %以下是错误的写法，虽然也能得到1*26的向量，但是计算顺序不对
    %delta2 = ( delta3 .* (a3(i,:) .* (1 - a3(i,:))) ) * Theta2;
    
    %正确写法
%     delta2 = delta3 * Theta2 .* [1 sigmoidGradient(z2(i,:))];
    delta2 = delta3 * Theta2 .* (a2(i,:) .* (1 - a2(i,:)));
    
    %计算△
    %△和Theta规格相同
    Delta2 = Delta2 + delta3' * a2(i,:);
    Delta1 = Delta1 + delta2(2:end)' * a1(i,:);
end

%正则化，第一列偏置部分不需要考虑
Theta1_grad(:,1) = 1/m * Delta1(:,1);
Theta2_grad(:,1) = 1/m * Delta2(:,1);

Theta1_grad(:,2:end) = 1/m * Delta1(:,2:end) + ...
    lambda / m * Theta1(:,2:end);
Theta2_grad(:,2:end) = 1/m * Delta2(:,2:end) + ...
    lambda / m * Theta2(:,2:end);

% -------------------------------------------------------------

% =========================================================================

%%  Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
