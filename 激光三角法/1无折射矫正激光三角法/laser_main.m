clear all; close all; clc;

g_src = '.\';

%% 获取激光点真实三维数据
src1 = [g_src, 'b1_rect.bmp']; 
model = 2;
[realHeight1, mask1] = getLaserHeight(src1, model);

figure;imshow(mask1);
% figure;mesh(realHeight1.z);
figure;mesh(realHeight1.z);
view(0, 0); title('Height1');
Height1 = realHeight1.z;
save('./Height1.mat','Height1');