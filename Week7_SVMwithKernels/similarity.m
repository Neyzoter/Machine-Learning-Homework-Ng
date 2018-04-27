%% ======高斯核函数的图形=====
clear all;close all;clc;
%x和l初始化
l = [3;5];
x = [0:0.1:6  ;  2:0.1:8];
x1 = x(1,:);
x2 = x(2,:);
[m,n] = size(x);
sml = zeros(n,n);

%similarity相似度函数
%高斯核函数
f1 = @(x,l,delta)exp(-sum((bsxfun(@minus,x,l).^2),1) / (2 * delta^2)); 


%% delta^2 =1时
delta = sqrt(1);
for i = 1:n
    for j = 1:n
        x = [x1(i);x2(j)];
        sml(i,j) = f1(x,l,delta);
    end
end

figure(1);
%三维图
subplot(1,2,1);
surf(x1,x2,sml);
title('delta^2=1时的相似度函数曲线');
xlabel('x1');ylabel('x2');zlabel('similarity');
%等高线图
subplot(1,2,2);
contour(x1,x2,sml);
title('delta^2=1时的相似度函数等高线');
xlabel('x1');ylabel('x2');zlabel('similarity');

%% delta^2 =0.5
delta =sqrt(0.5);
for i = 1:n
    for j = 1:n
        x = [x1(i);x2(j)];
        sml(i,j) = f1(x,l,delta);
    end
end
figure(2);
%三维图
subplot(1,2,1);
surf(x1,x2,sml);
title('delta^2=0.5时的相似度函数曲线');
xlabel('x1');ylabel('x2');zlabel('similarity');
%等高线
subplot(1,2,2);
contour(x1,x2,sml);
title('delta^2=0.5时的相似度函数等高线');
xlabel('x1');ylabel('x2');zlabel('similarity');

%% delta^2 =3
delta =sqrt(3);
for i = 1:n
    for j = 1:n
        x = [x1(i);x2(j)];
        sml(i,j) = f1(x,l,delta);
    end
end
figure(3);
%三维图
subplot(1,2,1)
surf(x1,x2,sml);
title('delta=3时的相似度函数曲线');
xlabel('x1');ylabel('x2');zlabel('similarity');
%等高线
subplot(1,2,2);
contour(x1,x2,sml);
title('delta=3时的相似度函数等高线');
xlabel('x1');ylabel('x2');zlabel('similarity');

