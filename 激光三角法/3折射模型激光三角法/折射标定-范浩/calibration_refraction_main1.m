clc; clear; close all;
%% camera calibration information
disp('---1--- camera calibration');
f_1 = 707.03023; %以毫米为单位做标定
f_2 = 706.89991;
alpha_c = 0;
cc_1 = 315.93375;
cc_2 = 231.14271;

%% 利用标定板的中间部分计算高度
disp('---2--- camera-water refraction calibration');
% 12为一组，34为一组，56为一组（斜面）
for i = 1:2
A = imread([int2str(i) '.bmp']);
figure;imshow(A);
hold on;

[x(1),y(1)] = ginput(1); % 只能选中间位置的一个棋盘格
plot(x(1),y(1),'p', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
[x(2),y(2)] = ginput(1); 
close all;

H = 33.8; % 测量值，单位为毫米
Z(i) = sqrt(H^2/( ((x(1)-x(2))/f_1)^2 + ((y(1)-y(2))/f_2)^2) );
end

%% 折射率和相机在空气中的传播垂直距离
disp('---3--- compute refraction -N- and camera distance -OK-');
OA = Z(1);  %空气
OD = Z(2); %水中
% N11 = OA1/OD1;
% N21 = OA2/OD2;


N = 1.333;
OK = (OA-N*OD)/(1-N);
result.OK = OK;
result.N = N
save('result.mat','result');
%某次标定结果 %OK=53 N=1.3226