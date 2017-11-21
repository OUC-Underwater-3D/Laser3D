clear all; close all; clc;

g_src = '.\';

%% ��ȡ�������ʵ��ά����
src1 = [g_src, 'cc3_rect.bmp']; %�޸�ͼƬ����
model = 2;
[realHeight1, mask1] = getLaserHeight(src1, model);

figure;imshow(mask1);
% figure;mesh(realHeight1.z);
figure;mesh(realHeight1.z);
view(0, 0); title('Height1');
Height1 = realHeight1.z;
save('./Height1.mat','Height1');

%������ʾ
figure;
hold on;
A=sum(Height1);
l=length(A);
x=1:1:l;
plot(x,A);
str=[repmat('  X:',l,1) num2str(x') repmat(', Y:',l,1) num2str(A')];
for i=1:200:l
plot(x(i),A(i),'*');
text(x(i),A(i),cellstr(str(i,:)));
end
hold off;