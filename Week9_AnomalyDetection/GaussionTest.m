close all;
clear;
clc;

disp('���-2��2֮����ܸ���Q');
Q = quadl(@(x)GaussionDistribution(x,0,1),-2,2)

x = -5:0.01:5;
figure('NumberTitle','off','Name','��˹�ֲ�����ͼ')
plot(x,GaussionDistribution(x,0,1));
grid on;


function y = GaussionDistribution(x,mu,stddv)
%GaussionDistribution ��˹�ֲ�
%x��������mu��mean��ƽ��ֵ��stddv��standard deviation����׼�
%���û�и���m�ͱ�׼���ôĬ��Ϊ0��1
    if ~exist('mu', 'var') || isempty(mu)
        mu = 0;
    end    
    if ~exist('stddv', 'var') || isempty(stddv)
        stddv = 1;
    end      
    
    y = 1 / sqrt(2*pi) / stddv * exp(- (x - mu).^2 / 2 /(stddv.^2));
end