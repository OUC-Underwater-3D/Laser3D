function laserH_dictionary = getLaserH_dictionary(img)
% img: 获取标定图片（尺寸）
% code by fanhao, 2017.07.11

clear all;close all; clc;
img = imread('w1_rect.bmp');
%% calibration information
disp('--1--camera calibration info');
f_1 = 2757.85389;
f_2 = 2764.69304;
alpha_c = 0;
cc_1 = 1252.18673;
cc_2 = 962.78821;

disp('--2--laser plane calibration info'); %pa+ pb*x + pc*y - z = 0
pa = 336.3568;
pb = 0.0144;
pc = -1.0398;
pd = -1;

disp('---3--- load camera-water refration calibration info');
N = 1.3336;
OK = 63;

%% 计算
disp('--3--compute laser height');
% 图像归一化坐标
[h, w] = size(img); %标定的图像尺寸
[X,Y] = meshgrid(1:w, 1:h);
x = (X - cc_1)/f_1 - alpha_c*(Y-cc_2)/f_2;
y = (Y - cc_2)/f_2;

%% compute laser height
delta = sqrt(N^2+(N^2-1)*(x.^2 + y.^2));
z_v = ((pd*OK).*(delta-1)-pa)./(pb.*x+pc.*y+delta.*pd);
% figure;mesh(z_v);

h_x = x .* z_v;
h_y = y .* z_v;
h_z = OK + (z_v-OK) .* delta;
h_z = pa - h_z;

laserH_dictionary.x = h_x;
laserH_dictionary.y = h_y;
laserH_dictionary.z = h_z;

%% save
disp('--4--save laser height');
save('laserH_dictionary.mat','laserH_dictionary');
figure;mesh(laserH_dictionary.z);
% pause;
