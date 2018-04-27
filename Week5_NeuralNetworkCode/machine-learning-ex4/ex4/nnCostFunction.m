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



%==˵��==������a��������㣬������ƫ��1


%��Xǰ����5000*1��һ��1�������Ϊa1
a1 = [ones(m,1) X];

%X��5000����*401������
%Theta1��25�����*401������
%z2�����ز�û�м���ʱ������z2
z2 = a1 * Theta1';
a2 = sigmoid(z2);%��һ�����5000��������5000�У���25���������У�
a2 = [ones(m,1) a2];%����ƫ��1

%Theta2��10�����*26������
%a3��5000����*10���
%z2�������û�м���ʱ������z3
z3 = a2 * Theta2';
a3 = sigmoid(z3);

%����log(h)��log(1-h)
logh = log(a3);
log1_h = log(1-a3);
%����y == Ref�õ�5000������*10�������

%1-num_labels������,���������10�Ļ������ڲ�ͬ�ķ��಻����
%Ref��������*�������
%�磺Ref = [1 0 0 ;0 1 0;0 1 0]
%��ʾ��һ�������Ƿ���1���ڶ����������Ƿ���2
Ref = 1:num_labels;
Ref = (y == Ref);
%% ����J
% % ����1����һ��һ���ӣ�
% for i = 1 : m
%     J = J - 1 / m * ( Ref(i,:) * (logh(i,:))' + ...
%         (1 - Ref(i,:)) * (log1_h(i,:))');
% end
% %����
% J =  J + 0.5 * lambda / m * (sum(sum(Theta1(:,2:end).^2)) + ...
%     sum(sum(Theta2(:,2:end).^2)));

%����2������������
%ע������ʱ��������ƫ�ò��ֵĲ���theta
J = - 1 / m * sum(sum(( Ref .* logh + (1 - Ref) .* log1_h))) + ...
    0.5 * lambda / m * (sum(sum(Theta1(:,2:end).^2)) + ...
    sum(sum(Theta2(:,2:end).^2)));

%% ===���򴫲�=====
%ʹ��Delta��Theta�ľ���һ�����
Delta2 = zeros(num_labels,hidden_layer_size+1);
Delta1 = zeros(hidden_layer_size,input_layer_size+1);
%��m�����ݽ��б���
for i = 1:m
    %�����
    %Ref��m*num_labels����Ϊyת��Ϊ������ʽ
    %delta3:1*num_labels
    delta3 = a3(i,:) - Ref(i,:);

    %���ز�
    %Theta2��10*26
    %delta3:1*num_labels
    %a3��m*hidden_layer_size��������ƫ��1
    %a2��1*26����һ��Ϊƫ��1
    %delta2��1*26   
    
    %�����Ǵ����д������ȻҲ�ܵõ�1*26�����������Ǽ���˳�򲻶�
    %delta2 = ( delta3 .* (a3(i,:) .* (1 - a3(i,:))) ) * Theta2;
    
    %��ȷд��
%     delta2 = delta3 * Theta2 .* [1 sigmoidGradient(z2(i,:))];
    delta2 = delta3 * Theta2 .* (a2(i,:) .* (1 - a2(i,:)));
    
    %�����
    %����Theta�����ͬ
    Delta2 = Delta2 + delta3' * a2(i,:);
    Delta1 = Delta1 + delta2(2:end)' * a1(i,:);
end

%���򻯣���һ��ƫ�ò��ֲ���Ҫ����
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
