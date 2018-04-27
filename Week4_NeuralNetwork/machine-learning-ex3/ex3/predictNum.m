%% ==============主函数文件说明=======================
%预测20*20图像内的数字

%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10
                          % (note that we have mapped "0" to label 10)
%% ===============读取训练集图片，并存储为mat的形式=============
SaveMydata;

%% =========== Loading Data =============
%  We start the exercise by first loading and visualizing the dataset.
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading Data ...\n')
pics = zeros(1000 , 400);
y = [10*ones(100,1);ones(100,1);2*ones(100,1);3*ones(100,1);4*ones(100,1);...
    5*ones(100,1);6*ones(100,1);7*ones(100,1);8*ones(100,1);9*ones(100,1)];

load('Mydata.mat'); % training data stored in arrays X, y
m = size(pics,1);%5000行
n = size(pics,2);%特征个数

% fprintf('Program paused. Press enter to continue.\n');
% pause;

%%  ===============Training=========================

fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;

%X加入1向量、y映射为0和1向量，优化算法得到参数
%但是和C语言一样，函数体调用参数，不会改变参数
[all_theta] = oneVsAll(pics, y, num_labels, lambda);
fprintf('all_theta\n');
% fprintf('Program paused. Press enter to continue.\n');
% pause;

%% ======计算训练集正确率
pred = predictOneVsAll(all_theta, pics);
%如果正确则为1，否则为0
%取平均，即为正确率
fprintf('\n训练集正确率: %0.2f%%\n', mean(double(pred == y)) * 100);

%% ========读取图片并转化为灰度图==========
fprintf('读取测试集图片...\n');
%预测数字图片编号
NumPred = 3;
fn = ['num_',int2str(NumPred),'.png'];
gray = double(rgb2gray(imread(fn)))/255;  % 特征缩放，转换为灰度图
figure(1);
imshow(gray);
%%  =============矩阵gray转化为行向量===================
pic = zeros(1,n);%用来存储预测的图像行向量
for i = 1:20
    for j = 1:20
        pic((i-1)*20+j) = gray(j,i);
    end
end
fprintf('成功读取测试集图片.\n');
figure(2);
displayData(pic);

%% ==========预测结果================
%预测
% pic = [1,pic];%前面加上1
% sigmoid(pic * all_theta')
% [Y p] = max(pic * all_theta',[],2);
pred = predictOneVsAll(all_theta, pic);
fprintf('预测概率%0.2f%%\n',sigmoid(pred)*100)
fprintf('预测数字')
if(pred == 10)
    0
else
    pred
end
fprintf('实际数字')
NumPred


