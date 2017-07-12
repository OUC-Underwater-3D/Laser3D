function [laserMask, mask] = getLaserHeight(filename,model)
% 为了降低激光平面的校准难度，对实验设备的精度有严格设置。laser1 竖直激光； laser2 水平激光
% clear all; close all; clc;
laserimage = imread(filename);
image = laserimage(:,:,1);
% imshow(image);

%% 加载整体激光高度图像字典
disp('1--load laser height dictionary');
laserH_dictionary = getLaserH_dictionary(image);

%% 加载激光掩膜
disp('2--load laser mask');
mask = findlaser(image, model); %model:1--rows--(laser_x), 2--cols-(laser_y)
% figure; imshow(mask);

%% 计算激光点世界坐标系下高度
disp('3--compute laser height');
laserMask.x = laserH_dictionary.x .* mask;
laserMask.y = laserH_dictionary.y .* mask;
laserMask.z = laserH_dictionary.z .* mask;

% h_z_mask = laserMask.z;
% Z = flipud(h_z_mask);
% figure;mesh(Z);
% pause;