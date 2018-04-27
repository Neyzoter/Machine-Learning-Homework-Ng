%% ======��˹�˺�����ͼ��=====
clear all;close all;clc;
%x��l��ʼ��
l = [3;5];
x = [0:0.1:6  ;  2:0.1:8];
x1 = x(1,:);
x2 = x(2,:);
[m,n] = size(x);
sml = zeros(n,n);

%similarity���ƶȺ���
%��˹�˺���
f1 = @(x,l,delta)exp(-sum((bsxfun(@minus,x,l).^2),1) / (2 * delta^2)); 


%% delta^2 =1ʱ
delta = sqrt(1);
for i = 1:n
    for j = 1:n
        x = [x1(i);x2(j)];
        sml(i,j) = f1(x,l,delta);
    end
end

figure(1);
%��άͼ
subplot(1,2,1);
surf(x1,x2,sml);
title('delta^2=1ʱ�����ƶȺ�������');
xlabel('x1');ylabel('x2');zlabel('similarity');
%�ȸ���ͼ
subplot(1,2,2);
contour(x1,x2,sml);
title('delta^2=1ʱ�����ƶȺ����ȸ���');
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
%��άͼ
subplot(1,2,1);
surf(x1,x2,sml);
title('delta^2=0.5ʱ�����ƶȺ�������');
xlabel('x1');ylabel('x2');zlabel('similarity');
%�ȸ���
subplot(1,2,2);
contour(x1,x2,sml);
title('delta^2=0.5ʱ�����ƶȺ����ȸ���');
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
%��άͼ
subplot(1,2,1)
surf(x1,x2,sml);
title('delta=3ʱ�����ƶȺ�������');
xlabel('x1');ylabel('x2');zlabel('similarity');
%�ȸ���
subplot(1,2,2);
contour(x1,x2,sml);
title('delta=3ʱ�����ƶȺ����ȸ���');
xlabel('x1');ylabel('x2');zlabel('similarity');

