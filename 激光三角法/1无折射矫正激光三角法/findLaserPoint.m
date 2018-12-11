function [x_matrix,y_matrix]=findLaserPoint(imageMat)
%numIMG = 'image71.bmp';
%numIMG = 'image416.bmp';
%numIMG = 'IMG8.bmp';
Img=imageMat;      %读取图像

doubleImg = double(Img);     %转换成double类型
%greenIMG = doubleImg( : , : , 2);
greenIMG = 2 * doubleImg( : , : , 1) - doubleImg( : , : , 2) - doubleImg( : , : , 3);
greenIMG = 2  * greenIMG - min(min(greenIMG));
%greenIMG = 255 * greenIMG / max(max(greenIMG));
greenIMG = uint8(greenIMG);       %无符号整形数据，取值范围从0到255
greenthresh = graythresh(greenIMG);     %graythresh是一个函数，功能是使用最大类间方差法找到图片的一个合适的阈值。利用这个阈值通常比人为设定的阈值能更好地把一张灰度图像转换为二值图像
IMGbw = im2bw( greenIMG , greenthresh);    %im2bw使用阈值（threshold）变换法把灰度图像（grayscale image）转换成二值图像。
IMGbw = bwareaopen(IMGbw,200,4);
B3=imcomplement(IMGbw);
IMGbw1 = IMGbw;
IMGbw1 =B3;
%计算质心坐标
[row, col] = size(IMGbw1);
%plot_x = zeros(1,col);      %记录质心位置的横坐标
%plot_y = zeros(1,col);      %记录质心位置的纵坐标
%figure, imshow(numIMG),title('end!');
plot_x = [];
plot_y = [];
 %figure, imshow(IMGbw),title('end!');
  %figure, imshow(greenIMG),title('end!');
 
%hold on
for i = 1:col
    I = IMGbw1(:, i);%I中的元素为第i的灰度值
    isZeros = any(I);%判断a是否为零向量 检测矩阵中是否有非零元素 如果有则返回1   255白
    if isZeros == 1
        [y, x] = find(I);%y为行数，表示纵坐标；x为列数，表示横坐标
        zero_index = y;              %%挑出所有的0的位置（也即索引值向量）
        zeros_amount = length(zero_index);
        if ((sum(y) == (y(1)*2+zeros_amount-1)*zeros_amount/2))
            colGrayNum = greenIMG(y);
            colGrayNumSum = sum(colGrayNum);
            colcentroid = double(colGrayNum).* double(y);
            
            plot_x = [plot_x i];
            plot_y = [plot_y sum(colcentroid) / colGrayNumSum];
            %plot(plot_x(i), plot_y(i), 'red.');
        else
            maxlocal = 0;
            tempcount = 0;
            count = 1;
            
            for j = 1: (zeros_amount-1)
                
                if (y(j)==(y(j+1)-1))
                    count = count + 1 ;
                else
                    if (count > tempcount)
                        maxlocal =j+1;
                        tempcount = count;
                    end
                    count = 1;
                end
                if (count > tempcount)
                    maxlocal =j+2;
                    tempcount = count;
                end
            end
            colGrayNum = greenIMG(y((maxlocal-tempcount):(maxlocal-1)));
            colGrayNumSum = sum(colGrayNum);
            colcentroid = double(colGrayNum).* double(y((maxlocal-tempcount):(maxlocal-1)));
%             plot_x(i) = i;
%             plot_y(i) = sum(colcentroid) / colGrayNumSum;
% 
%             plot(plot_x(i), plot_y(i), 'red.');
            plot_x = [plot_x i];
            plot_y = [plot_y sum(colcentroid) / colGrayNumSum];
        end
    end
end
 x_matrix = plot_x;
 y_matrix = plot_y;
end

