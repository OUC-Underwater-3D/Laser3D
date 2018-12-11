%% 
%function [h_x,h_y,h_z]=getLaserH(x_matrix,y_matrix,f_1,f_2,cc_1,cc_2,para)
function [X_c, Y_c, Z_c]=getLaserH(x_matrix, y_matrix, f_1, f_2, cc_1, cc_2, para)

disp('--1--camera calibration info');
alpha_c = 0;
disp('--2--laser plane calibration info'); %pa+ pb*x + pc*y - z = 0
%pa = 336.3568;
%pb = 0.0144;
%pc = -1.0398;
%pd = -1;
%pa =  716.5482;
%pb =  -0.0043;
%pc =  -0.9847;
pa = para(1);
pb = para(2);
pc = para(3);
pd = -1;
%% 计算
disp('--3--compute laser height');
% 图像归一化坐标
%[h, w] = size(img); %标定的图像尺寸
%[X,Y]= meshgrid(1:w, 1:h);
x = (x_matrix - cc_1) / f_1 - alpha_c * (x_matrix-cc_2) / f_2;
y = (y_matrix - cc_2) / f_2;

%% compute laser height
%激光平面是在相机坐标系下的
Z_c = -pa ./ (pb.*x + pc.*y + pd); 
X_c = x .* Z_c;
Y_c = y .* Z_c;
Z_c = pa - Z_c;