function [] = SaveMydata()
% SAVEMYDATA 存储图片到mat
clear ;close all;clc;
pics = zeros(1000 , 400);

maindir = 'I:\Gratitude\MachineLearning\AndrewNg\Week4_NeuralNetwork\machine-learning-ex3\ex3\Mydata';  
subdir =  dir( maindir );   % 先确定子文件夹  

for i = 3 : length( subdir )  %第一行和第二行为文件夹.和..
    if( isequal( subdir( i ).name, '.' ) ||  isequal( subdir( i ).name, '..' ) ||  ~subdir( i ).isdir )   % 如果不是目录跳过  
        continue;  
    end  
      
    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );  
    images = dir( subdirpath );   % 在这个子文件夹下找后缀为png的文件    
    % 遍历每张图片  
    for j = 1 : length( images )  
        imagepath = fullfile( maindir, subdir( i ).name, images( j ).name);  
         imgdata = imread( imagepath );   % 这里进行你的读取操作 
         gray =double(rgb2gray(imgdata))/255;%特征缩放
         pics((i-3)*length( images ) +j,:) = gray(:);
%          displayData(pics((i-3)*length( images ) +j,:));
    end  
end
save('Mydata.mat','pics');

end
