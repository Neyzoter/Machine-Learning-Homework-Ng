%% ==============�������ļ�˵��=======================
%Ԥ��20*20ͼ���ڵ�����

%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10
                          % (note that we have mapped "0" to label 10)
%% ===============��ȡѵ����ͼƬ�����洢Ϊmat����ʽ=============
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
m = size(pics,1);%5000��
n = size(pics,2);%��������

% fprintf('Program paused. Press enter to continue.\n');
% pause;

%%  ===============Training=========================

fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;

%X����1������yӳ��Ϊ0��1�������Ż��㷨�õ�����
%���Ǻ�C����һ������������ò���������ı����
[all_theta] = oneVsAll(pics, y, num_labels, lambda);
fprintf('all_theta\n');
% fprintf('Program paused. Press enter to continue.\n');
% pause;

%% ======����ѵ������ȷ��
pred = predictOneVsAll(all_theta, pics);
%�����ȷ��Ϊ1������Ϊ0
%ȡƽ������Ϊ��ȷ��
fprintf('\nѵ������ȷ��: %0.2f%%\n', mean(double(pred == y)) * 100);

%% ========��ȡͼƬ��ת��Ϊ�Ҷ�ͼ==========
fprintf('��ȡ���Լ�ͼƬ...\n');
%Ԥ������ͼƬ���
NumPred = 3;
fn = ['num_',int2str(NumPred),'.png'];
gray = double(rgb2gray(imread(fn)))/255;  % �������ţ�ת��Ϊ�Ҷ�ͼ
figure(1);
imshow(gray);
%%  =============����grayת��Ϊ������===================
pic = zeros(1,n);%�����洢Ԥ���ͼ��������
for i = 1:20
    for j = 1:20
        pic((i-1)*20+j) = gray(j,i);
    end
end
fprintf('�ɹ���ȡ���Լ�ͼƬ.\n');
figure(2);
displayData(pic);

%% ==========Ԥ����================
%Ԥ��
% pic = [1,pic];%ǰ�����1
% sigmoid(pic * all_theta')
% [Y p] = max(pic * all_theta',[],2);
pred = predictOneVsAll(all_theta, pic);
fprintf('Ԥ�����%0.2f%%\n',sigmoid(pred)*100)
fprintf('Ԥ������')
if(pred == 10)
    0
else
    pred
end
fprintf('ʵ������')
NumPred


