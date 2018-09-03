% function [x_matrix,y_matrix]=findLaserPoint(imageMat)
% %disp('_____________________________');
% %disp(imageName);
% %%Img=imread(imageName);
% Img = imageMat;
% %
% %亚像素级激光线中心点提取
% %时间：2017年12月25日
% %Version：1.2
% %提取方法：质心法
% %处理过程：
% %1.预处理
% %2.形态学处理
% %3.质心法求解
% %4.得出结果并在原图像上作图
% %共包含三个函数
% %numIMG = 'IMG4.bmp';
% %Img=imread(numIMG);      %读取图像
% 
% doubleImg = double(Img);     %转换成double类型
% greenIMG = 2 * doubleImg( : , : , 2) - doubleImg( : , : , 1) - doubleImg( : , : , 3);
% greenIMG = greenIMG - min(min(greenIMG));
% greenIMG = 255 * greenIMG / max(max(greenIMG));
% greenIMG = uint8(greenIMG);       %无符号整形数据，取值范围从0到255
% % figure,imshow(greenIMG);
% %greenthresh = graythresh(greenIMG);     %不调整阈值 进行对比
% greenthresh = graythresh(greenIMG) - 0.08;     %graythresh是一个函数，功能是使用最大类间方差法找到图片的一个合适的阈值。利用这个阈值通常比人为设定的阈值能更好地把一张灰度图像转换为二值图像
% IMGbw = im2bw( greenIMG , greenthresh);    %im2bw使用阈值（threshold）变换法把灰度图像（grayscale image）转换成二值图像。
% erodeElement = strel('square', 1);      %创建一个矩形框1*1腐蚀算子
% dilateElement = strel('square', 3);
% % IMGbw = imdilate(IMGbw, dilateElement);
% % IMGbw = imerode(IMGbw, erodeElement);
% IMGbw = imfill(IMGbw,'holes');      %填充二值图像中的空洞区域。 如， 黑色的背景上有个白色的圆圈。 则这个圆圈内区域将被填充
% % IMGbw = imdilate(IMGbw, dilateElement);
% % IMGbw = imerode(IMGbw, erodeElement);
% % IMGthin = bwmorph(IMGbw,'thin',4);        %对二值图像进行n次指定的细化处理。
% IMGbw1 = bwareaopen(IMGbw,50);      %删除二值图像f中面积小于100的对象，默认情况下conn使用8邻域
% 
% %IMGbw1 = IMGbw;
% %计算质心坐标
% %Img=imread(numIMG);      %读取图像
% [row, col] = size(IMGbw1);
% %[rowgray,colgray] = greenIMG;
% %rowgray = greenIMG(:,2);
% %colgray = greenIMG(:,1);
% plot_x = zeros(1,col);      %记录质心位置的横坐标
% plot_y = zeros(1,col);      %记录质心位置的纵坐标
% %figure, imshow(Img),title('end!');
% %hold on
% for i = 1:col
%     I = IMGbw1(:, i);%I中的元素为第i的灰度值
%     isZeros = any(I);%判断a是否为零向量 检测矩阵中是否有非零元素 如果有则返回1   255白
%     if isZeros == 1
%         [y, x] = find(I);%y为行数，表示纵坐标；x为列数，表示横坐标
%         zero_index = y;              %%挑出所有的0的位置（也即索引值向量）
%         zeros_amount = length(zero_index);
%         if ((sum(y) == (y(1)*2+zeros_amount-1)*zeros_amount/2))
% %             [count, count1] = size(y);%count表示坐标的个数
%                     colGrayNum = greenIMG(y);
%                     colGrayNumSum = sum(colGrayNum);
%                     colcentroid = double(colGrayNum).* double(y);
% %             sum_x = sum(x);%横坐标的和
% %             sum_y = sum(y);%纵坐标的和
%             %
%             %         [~,loc]=ismember(colGrayNum,greenIMG(:,i));  %如果Matlab版本较低，可以把“~”换成任意未使用的变量名，比如“ignore”
%             %         C=cell(size(colGrayNum));
%             %         ind=loc(loc>0);
%             %         C(loc>0)=mat2cell(greenIMG(ind,2:end),ones(length(ind),1));
%             %质心公式
%             plot_x(i) = i;
%             plot_y(i) = sum(colcentroid) / colGrayNumSum;
% %             plot_y(i) = sum_y/count;
%             %plot(plot_x(i), plot_y(i), 'b.');
%         else
%             maxlocal = 0;
%             tempcount = 0;
%             count = 1;
%             
%             for j = 1: (zeros_amount-1)
%                
%                 if (y(j)==(y(j+1)-1))
%                     count = count + 1 ;
%                 else
%                     if (count > tempcount)
%                         maxlocal =j+1;
%                         tempcount = count;
%                     end
%                     count = 1;
%                 end
%             end
%             %[count, count1] = size(y(maxlocal-tempcount):maxlocal);
%             %sum_y = sum(y((maxlocal-tempcount):(maxlocal-1)));
%             colGrayNum = greenIMG(y((maxlocal-tempcount):(maxlocal-1)));
%             colGrayNumSum = sum(colGrayNum);
%             colcentroid = double(colGrayNum).* double(y((maxlocal-tempcount):(maxlocal-1)));
%             plot_x(i) = i;
%             %plot_y(i) = mean(y((maxlocal-tempcount):maxlocal));
%             %plot_y(i) = mean(y);
%             plot_y(i) = sum(colcentroid) / colGrayNumSum;
% %             plot_y(i) = sum_y/tempcount;
%             %plot(plot_x(i), plot_y(i), 'b.');
%         end
%     end
% end
% x_matrix = plot_x;
% y_matrix = plot_y;
%% -------------------------------------------------------------
% function [x_matrix,y_matrix]=findLaserPoint(imageMat)
% %clear;
% % locStr：图片相对路径
% %  locStr= 'IMG1.bmp'; 
% %  locStr = 'IMG3.bmp';
% %  locStr = 'image71.bmp';
% %  locStr = 'IMG11.bmp';
% %  locStr = 'IMG5.bmp';
%  % locStr = 'IMG22.bmp';
%  %  locStr = 'IMG63.bmp';
%  % locStr = 'L799.bmp';
% 
% %读取图像到图像数组rgb
% %rgb=imread(locStr);   
% Img = imageMat;
% %转换成double类型
% d_rgb = double(Img);
% 
% %获得绿色通道值
% g = d_rgb( : , : , 2);
% g = g - min(min(g));
% g = 255 * g / max(max(g));
% 
% %无符号整形数据，取值范围从0到255
% gray_g = uint8(g);  
% 
% %graythresh是一个函数，功能是使用最大类间方差法
% %找到图片的一个合适的阈值。
% %利用这个阈值通常比人为设定的阈值
% %能更好地把一张灰度图像转换为二值图像
% g_thresh = graythresh(gray_g);     
% 
% %im2bw使用阈值（threshold）变换法把
% %灰度图像（grayscale image）转换成二值图像。
% bw_g = im2bw( gray_g , g_thresh);   
% 
% %计算质心坐标
% [row, col] = size(bw_g);
% 
%  %记录质心位置的纵坐标
% plot_y = zeros(1,col);     
% 
%  figure, imshow(Img),title('end!');
%   figure, imshow(bw_g),title('end!');
% 
% hold on
% 
% for i = 1:col
%     %I中的元素为第i的0、1
%     I = bw_g(:, i);
%     %判断a是否为零向量 检测矩阵中是否有非零元素 如果有则返回1   255白
%     isZeros = any(I);
%     plot_x(i) = i;
%     if isZeros == 1
%         %y为行数，表示纵坐标；x为列数，表示横坐标
%         [y, x] = find(I);
%          %%挑出所有的0的位置（也即索引值向量）
%         zero_index = y;             
%         zeros_amount = length(zero_index);
%         if ((sum(y) == (y(1)*2+zeros_amount-1)*zeros_amount/2))
%             colGray = gray_g(y);
%             colGrayCount = sum(colGray);
%             colCentroid = double(colGray).* double(y);
%             
%             plot_y(i) = sum(colCentroid) / colGrayCount;
%             plot(i, plot_y(i), 'b.');
%         else
%             %行数值最大的位置
%             maxlocal = 0;
%             %连续点的个数临时存储
%             tempcount = 0;
%             %连续点的个数
%             count = 1;
%             for j = 1: (zeros_amount-1)
%                 %若y(j+1)为y(j)下一个连续的点，数量+1
%                 if (y(j)==(y(j+1)-1))
%                     count = count + 1 ;
%                 %否则断开了，count置1
%                 else
%                     count = 1;
%                 end
%                 %和最大点连续存储值判断一下
%                 if (count > tempcount)
%                     maxlocal =j+1;
%                     tempcount = count;
%                 end
%             end
%             colGray = gray_g(y((maxlocal-tempcount+1):(maxlocal)));
%             colGrayCount = sum(colGray);
%             colCentroid = double(colGray).* double(y((maxlocal-tempcount+1):(maxlocal)));
%             plot_y(i) = sum(colCentroid) / colGrayCount;
%             plot(i, plot_y(i), 'b.');
%         end
%     end
% end
% x_matrix = plot_x;
% y_matrix = plot_y;
% disp(size(x_matrix));
% disp(size(y_matrix));
% end
%% ------------------------------------------------------------------
% function [x_matrix,y_matrix]=findLaserPoint(imageMat)
% %numIMG = 'image71.bmp';
% %numIMG = 'image416.bmp';
% %numIMG = 'IMG8.bmp';
% Img=imageMat;      %读取图像
% 
% doubleImg = double(Img);     %转换成double类型
% %greenIMG = doubleImg( : , : , 2);
% greenIMG = 2 * doubleImg( : , : , 1) - doubleImg( : , : , 2) - doubleImg( : , : , 3);
% greenIMG = 2  * greenIMG - min(min(greenIMG));
% %greenIMG = 255 * greenIMG / max(max(greenIMG));
% greenIMG = uint8(greenIMG);       %无符号整形数据，取值范围从0到255
% greenthresh = graythresh(greenIMG);     %graythresh是一个函数，功能是使用最大类间方差法找到图片的一个合适的阈值。利用这个阈值通常比人为设定的阈值能更好地把一张灰度图像转换为二值图像
% IMGbw = im2bw( greenIMG , greenthresh);    %im2bw使用阈值（threshold）变换法把灰度图像（grayscale image）转换成二值图像。
% B3=imcomplement(IMGbw);
% IMGbw1 = IMGbw;
% IMGbw1 =B3;
% %计算质心坐标
% [row, col] = size(IMGbw1);
% plot_x = [];      %记录质心位置的横坐标
% plot_y = [];      %记录质心位置的纵坐标
% % figure, imshow(numIMG),title('end!');
% %  %figure, imshow(IMGbw),title('end!');
% %   %figure, imshow(greenIMG),title('end!');
% %  
% % hold on
% for i = 1:col
%     I = IMGbw1(:, i);%I中的元素为第i的灰度值
%     isZeros = any(I);%判断a是否为零向量 检测矩阵中是否有非零元素 如果有则返回1   255白
%     if isZeros == 1
%         [y, x] = find(I);%y为行数，表示纵坐标；x为列数，表示横坐标
%         zero_index = y;              %%挑出所有的0的位置（也即索引值向量）
%         zeros_amount = length(zero_index);
%         if ((sum(y) == (y(1)*2+zeros_amount-1)*zeros_amount/2))
%             colGrayNum = greenIMG(y);
%             colGrayNumSum = sum(colGrayNum);
%             colcentroid = double(colGrayNum).* double(y);
%             
%             plot_x(i) = [plot_x i];
%             plot_y(i) = [plot_y sum(colcentroid) / colGrayNumSum];
% %             plot(plot_x(i), plot_y(i), 'red.');由于使用了上面这种形式，所以不能plot了
%         else
%             maxlocal = 0;
%             tempcount = 0;
%             count = 1;
%             
%             for j = 1: (zeros_amount-1)
%                 
%                 if (y(j)==(y(j+1)-1))
%                     count = count + 1 ;
%                 else
%                     if (count > tempcount)
%                         maxlocal =j+1;
%                         tempcount = count;
%                     end
%                     count = 1;
%                 end
%                 if (count > tempcount)
%                     maxlocal =j+2;
%                     tempcount = count;
%                 end
%             end
%             colGrayNum = greenIMG(y((maxlocal-tempcount):(maxlocal-1)));
%             colGrayNumSum = sum(colGrayNum);
%             colcentroid = double(colGrayNum).* double(y((maxlocal-tempcount):(maxlocal-1)));
% %             plot_x(i) = i;
% %             plot_y(i) = sum(colcentroid) / colGrayNumSum;
%             plot_x(i) = [plot_x i];
%             plot_y(i) = [plot_y sum(colcentroid) / colGrayNumSum];
% %             plot(plot_x(i), plot_y(i), 'red.');
%         end
%     end
% end
%  x_matrix = plot_x;
%  y_matrix = plot_y;
% end
% % for j = 1:1:col
% %     plot(plot_x(j), plot_y(j), 'y.')
% % end
% % hold on
%% 
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

