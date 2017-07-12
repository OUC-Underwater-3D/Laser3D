im = imread('bc1.bmp');

imtool(im); % 方便选取阈值使用

bw = zeros(486, 648);
bw(im(:,:,1)< 60 & im(:,:,2)>70 & im(:,:,3) < 60) = 1;
figure; imshow(im);
figure; imshow(bw);

figure;
subplot(1,3,1);
imshow(im);  [H,T,R] = hough(bw);%计算二值图像的标准霍夫变换，H为霍夫变换矩阵，I,R为计算霍夫变换的角度和半径值
subplot(1,3,2);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough变换的图像
xlabel('\theta'), ylabel('\rho');
axis on,axis square,hold on;
P  = houghpeaks(H,3);%提取3个极值点
x = T(P(:,2));
y = R(P(:,1));
plot(x,y,'s','color','white');%标出极值点
lines=houghlines(bw,T,R,P);%提取线段
subplot(1,3,3);
imshow(im), hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%画出线段
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%起点
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%终点
end