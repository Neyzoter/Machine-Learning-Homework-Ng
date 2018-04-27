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

% epsilonѡȡ�ļ��
stepsize = (max(pval) - min(pval)) / 1000;
% ����Գ�epsilon��ȡֵ�ĸ����
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

    % �õ�Ԥ�������y=1��0�Ľ��
    % pvalС����ֵ��1
    predictions = (pval < epsilon);
    
    % �����ԣ�Ԥ����1��ʵ����0
    fp = sum((predictions == 1) & (yval == 0));
    % �����ԣ�Ԥ���ʵ�ʶ���1
    tp = sum((predictions == 1) & (yval == 1));
    % �����ԣ�Ԥ����0��ʵ����1
    fn = sum((predictions == 0) & (yval == 1));
    
    % precision��׼��
    precision  = tp / (tp + fp);
    % �ٻ���
    recall = tp / (tp + fn);
    
    % F1 Score
    F1 = 2 * precision * recall/(precision + recall);
    
    % =============================================================
    % ������õ�F1��epsilon
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
