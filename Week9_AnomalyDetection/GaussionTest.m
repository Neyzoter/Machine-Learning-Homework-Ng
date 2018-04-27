close all;
clear;
clc;

disp('输出-2到2之间的总概率Q');
Q = quadl(@(x)GaussionDistribution(x,0,1),-2,2)

x = -5:0.01:5;
figure('NumberTitle','off','Name','高斯分布概率图')
plot(x,GaussionDistribution(x,0,1));
grid on;


function y = GaussionDistribution(x,mu,stddv)
%GaussionDistribution 高斯分布
%x：变量；mu：mean，平均值；stddv：standard deviation，标准差。
%如果没有给出m和标准差，那么默认为0和1
    if ~exist('mu', 'var') || isempty(mu)
        mu = 0;
    end    
    if ~exist('stddv', 'var') || isempty(stddv)
        stddv = 1;
    end      
    
    y = 1 / sqrt(2*pi) / stddv * exp(- (x - mu).^2 / 2 /(stddv.^2));
end