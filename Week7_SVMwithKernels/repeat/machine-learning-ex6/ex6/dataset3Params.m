function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

%最大预测正确率
Accuracy = 0;

%C的8个测试值
C_temp = [0.01 0.03 0.1 0.3 1 3 10 30];
Num_C  = size(C_temp,2); 
%sigma的8个测试值
sigma_temp = [0.01 0.03 0.1 0.3 1 3 10 30];
Num_sigma = size(sigma_temp,2);

for i = 1 : Num_C
    for j = 1 : Num_sigma
        model= svmTrain(X, y, C_temp(i),...
            @(x1, x2) gaussianKernel(x1, x2, sigma_temp(j) ) ); 
        predictions = svmPredict(model, Xval);%预测结果
        Acc_temp = mean(double(predictions == yval));%正确率
        if Accuracy < Acc_temp   %如果正确率比上次高
            Accuracy = Acc_temp;
            C = C_temp(i);
            sigma = sigma_temp(j);
            fprintf('\n\n===============\n更新...\nC = %f\nsigma = %f\n===============\n\n',C,sigma);
        end
        
    end
end

% =========================================================================
fprintf('======最终结果======\nC = %0.3f\nsigma = %0.3f\nAccuracy = %0.2f%%\n\n',C,sigma,100*Accuracy);
end
