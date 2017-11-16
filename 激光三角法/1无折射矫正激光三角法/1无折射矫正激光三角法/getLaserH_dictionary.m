function laserH_dictionary = getLaserH_dictionary(img)
% img: ��ȡ�궨ͼƬ���ߴ磩

% g_src = '';
%% calibration information
% disp('--1--camera calibration info');
% f_1 = 2122.67054;
% f_2 = 2122.11883;
% alpha_c = 0;
% cc_1 = 806.40633;
% cc_2 = 596.10524;
% 
% disp('--2--laser plane calibration info'); %pa+ pb*x + pc*y - z = 0
% pa = 0.5246;
% pb = -0.0055;
% pc = -1.3788;
% pd = -1;
% % disp('--1--camera calibration info');
% % f_1 = 702.59358;
% % f_2 = 703.49340;
% % alpha_c = 0;
% % cc_1 = 303.06242;
% % cc_2 = 227.21638;
% % 
% % disp('--2--laser plane calibration info'); %pa+ pb*x + pc*y - z = 0
% % pa = 0.4750;
% % pb = -0.0644;
% % pc = -1.7592;
% % pd = -1;
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
%% ����
disp('--3--compute laser height');
% ͼ���һ������
[h, w] = size(img); %�궨��ͼ��ߴ�
[X,Y]= meshgrid(1:w, 1:h);
x = (X - cc_1)/f_1 - alpha_c*(Y-cc_2)/f_2;
y = (Y - cc_2)/f_2;

%% compute laser height
h_z = -pa ./ (pb.*x + pc.*y + pd);
h_x = x .* h_z;
h_y = y .* h_z;
h_z = pa - h_z;

laserH_dictionary.x = h_x;
laserH_dictionary.y = h_y;
laserH_dictionary.z = h_z;

%% save
disp('--4--save laser height');
save('laserH_dictionary.mat','laserH_dictionary');
% figure;mesh(laserH_dictionary.z);
% pause;
