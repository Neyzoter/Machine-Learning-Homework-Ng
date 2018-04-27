function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

% epsilon选取的间隔
stepsize = (max(pval) - min(pval)) / 1000;
% 逐个试出epsilon的取值哪个最好
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    % 得到预测出来是y=1和0的结果
    % pval小于阈值是1
    predictions = (pval < epsilon);
    
    % 假阳性，预测是1，实际是0
    fp = sum((predictions == 1) & (yval == 0));
    % 真阳性，预测和实际都是1
    tp = sum((predictions == 1) & (yval == 1));
    % 假阴性，预测是0，实际是1
    fn = sum((predictions == 0) & (yval == 1));
    
    % precision查准率
    precision  = tp / (tp + fp);
    % 召回率
    recall = tp / (tp + fn);
    
    % F1 Score
    F1 = 2 * precision * recall/(precision + recall);
    
    % =============================================================
    % 更新最好的F1和epsilon
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
