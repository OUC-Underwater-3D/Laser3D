g_src = './';
imgDir  = dir([g_src '*.bmp']); % 遍历所有tif格式文件
%文件名格式：[Investigation].[texturename].[rotation].[slant].[tilt].[format]

g_pic_num = length(imgDir);
for i = 1:g_pic_num          % 遍历结构体一一处理图片
    %提取所有图片并将其拼接为一个大矩阵I
    image = imread([g_src imgDir(i).name]); %读取每张图片
    image = imresize(image, 0.25);
    imwrite(image, ['b' imgDir(i).name]);
end