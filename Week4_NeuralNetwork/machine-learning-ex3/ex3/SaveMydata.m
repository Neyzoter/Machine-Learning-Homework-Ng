function [] = SaveMydata()
% SAVEMYDATA �洢ͼƬ��mat
clear ;close all;clc;
pics = zeros(1000 , 400);

maindir = 'I:\Gratitude\MachineLearning\AndrewNg\Week4_NeuralNetwork\machine-learning-ex3\ex3\Mydata';  
subdir =  dir( maindir );   % ��ȷ�����ļ���  

for i = 3 : length( subdir )  %��һ�к͵ڶ���Ϊ�ļ���.��..
    if( isequal( subdir( i ).name, '.' ) ||  isequal( subdir( i ).name, '..' ) ||  ~subdir( i ).isdir )   % �������Ŀ¼����  
        continue;  
    end  
      
    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );  
    images = dir( subdirpath );   % ��������ļ������Һ�׺Ϊpng���ļ�    
    % ����ÿ��ͼƬ  
    for j = 1 : length( images )  
        imagepath = fullfile( maindir, subdir( i ).name, images( j ).name);  
         imgdata = imread( imagepath );   % ���������Ķ�ȡ���� 
         gray =double(rgb2gray(imgdata))/255;%��������
         pics((i-3)*length( images ) +j,:) = gray(:);
%          displayData(pics((i-3)*length( images ) +j,:));
    end  
end
save('Mydata.mat','pics');

end
