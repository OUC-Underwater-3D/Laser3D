A=imread('cc_rect3.bmp');
imshow(A);

disp('---1--- load camera calibration info');
f_1 = 707.03023;
f_2 = 706.89991;
alpha_c = 0;
cc_1 = 315.93375;
cc_2 = 231.14271;

% 图像归一化坐标
[h, w, c] = size(A); %标定的图像尺寸
[X,Y]= meshgrid(1:w, 1:h);
x = (X - cc_1)/f_1;
y = (Y - cc_2)/f_2;
n=1.333;
temp = sqrt(n.^2+(n.^2-1).*(x.^2+y.^2));
xx = x./temp;
yy = y./temp;

XX = xx.*f_1+cc_1;
YY = yy.*f_2+cc_2;

result = uint8(zeros(h, w, c));
for i = 1:h
    for j = 1:w
        cols_x = floor(XX(i,j));
        raws_y = floor(YY(i,j));
        result(raws_y, cols_x,:) = A(i,j,:);
    end
end

imshow(result);

