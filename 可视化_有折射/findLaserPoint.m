% function [x_matrix,y_matrix]=findLaserPoint(imageMat)
% %disp('_____________________________');
% %disp(imageName);
% %%Img=imread(imageName);
% Img = imageMat;
% %
% %�����ؼ����������ĵ���ȡ
% %ʱ�䣺2017��12��25��
% %Version��1.2
% %��ȡ���������ķ�
% %������̣�
% %1.Ԥ����
% %2.��̬ѧ����
% %3.���ķ����
% %4.�ó��������ԭͼ������ͼ
% %��������������
% %numIMG = 'IMG4.bmp';
% %Img=imread(numIMG);      %��ȡͼ��
% 
% doubleImg = double(Img);     %ת����double����
% greenIMG = 2 * doubleImg( : , : , 2) - doubleImg( : , : , 1) - doubleImg( : , : , 3);
% greenIMG = greenIMG - min(min(greenIMG));
% greenIMG = 255 * greenIMG / max(max(greenIMG));
% greenIMG = uint8(greenIMG);       %�޷����������ݣ�ȡֵ��Χ��0��255
% % figure,imshow(greenIMG);
% %greenthresh = graythresh(greenIMG);     %��������ֵ ���жԱ�
% greenthresh = graythresh(greenIMG) - 0.08;     %graythresh��һ��������������ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ�����������ֵͨ������Ϊ�趨����ֵ�ܸ��õذ�һ�ŻҶ�ͼ��ת��Ϊ��ֵͼ��
% IMGbw = im2bw( greenIMG , greenthresh);    %im2bwʹ����ֵ��threshold���任���ѻҶ�ͼ��grayscale image��ת���ɶ�ֵͼ��
% erodeElement = strel('square', 1);      %����һ�����ο�1*1��ʴ����
% dilateElement = strel('square', 3);
% % IMGbw = imdilate(IMGbw, dilateElement);
% % IMGbw = imerode(IMGbw, erodeElement);
% IMGbw = imfill(IMGbw,'holes');      %����ֵͼ���еĿն����� �磬 ��ɫ�ı������и���ɫ��ԲȦ�� �����ԲȦ�����򽫱����
% % IMGbw = imdilate(IMGbw, dilateElement);
% % IMGbw = imerode(IMGbw, erodeElement);
% % IMGthin = bwmorph(IMGbw,'thin',4);        %�Զ�ֵͼ�����n��ָ����ϸ������
% IMGbw1 = bwareaopen(IMGbw,50);      %ɾ����ֵͼ��f�����С��100�Ķ���Ĭ�������connʹ��8����
% 
% %IMGbw1 = IMGbw;
% %������������
% %Img=imread(numIMG);      %��ȡͼ��
% [row, col] = size(IMGbw1);
% %[rowgray,colgray] = greenIMG;
% %rowgray = greenIMG(:,2);
% %colgray = greenIMG(:,1);
% plot_x = zeros(1,col);      %��¼����λ�õĺ�����
% plot_y = zeros(1,col);      %��¼����λ�õ�������
% %figure, imshow(Img),title('end!');
% %hold on
% for i = 1:col
%     I = IMGbw1(:, i);%I�е�Ԫ��Ϊ��i�ĻҶ�ֵ
%     isZeros = any(I);%�ж�a�Ƿ�Ϊ������ ���������Ƿ��з���Ԫ�� ������򷵻�1   255��
%     if isZeros == 1
%         [y, x] = find(I);%yΪ��������ʾ�����ꣻxΪ��������ʾ������
%         zero_index = y;              %%�������е�0��λ�ã�Ҳ������ֵ������
%         zeros_amount = length(zero_index);
%         if ((sum(y) == (y(1)*2+zeros_amount-1)*zeros_amount/2))
% %             [count, count1] = size(y);%count��ʾ����ĸ���
%                     colGrayNum = greenIMG(y);
%                     colGrayNumSum = sum(colGrayNum);
%                     colcentroid = double(colGrayNum).* double(y);
% %             sum_x = sum(x);%������ĺ�
% %             sum_y = sum(y);%������ĺ�
%             %
%             %         [~,loc]=ismember(colGrayNum,greenIMG(:,i));  %���Matlab�汾�ϵͣ����԰ѡ�~����������δʹ�õı����������硰ignore��
%             %         C=cell(size(colGrayNum));
%             %         ind=loc(loc>0);
%             %         C(loc>0)=mat2cell(greenIMG(ind,2:end),ones(length(ind),1));
%             %���Ĺ�ʽ
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
% % locStr��ͼƬ���·��
% %  locStr= 'IMG1.bmp'; 
% %  locStr = 'IMG3.bmp';
% %  locStr = 'image71.bmp';
% %  locStr = 'IMG11.bmp';
% %  locStr = 'IMG5.bmp';
%  % locStr = 'IMG22.bmp';
%  %  locStr = 'IMG63.bmp';
%  % locStr = 'L799.bmp';
% 
% %��ȡͼ��ͼ������rgb
% %rgb=imread(locStr);   
% Img = imageMat;
% %ת����double����
% d_rgb = double(Img);
% 
% %�����ɫͨ��ֵ
% g = d_rgb( : , : , 2);
% g = g - min(min(g));
% g = 255 * g / max(max(g));
% 
% %�޷����������ݣ�ȡֵ��Χ��0��255
% gray_g = uint8(g);  
% 
% %graythresh��һ��������������ʹ�������䷽�
% %�ҵ�ͼƬ��һ�����ʵ���ֵ��
% %���������ֵͨ������Ϊ�趨����ֵ
% %�ܸ��õذ�һ�ŻҶ�ͼ��ת��Ϊ��ֵͼ��
% g_thresh = graythresh(gray_g);     
% 
% %im2bwʹ����ֵ��threshold���任����
% %�Ҷ�ͼ��grayscale image��ת���ɶ�ֵͼ��
% bw_g = im2bw( gray_g , g_thresh);   
% 
% %������������
% [row, col] = size(bw_g);
% 
%  %��¼����λ�õ�������
% plot_y = zeros(1,col);     
% 
%  figure, imshow(Img),title('end!');
%   figure, imshow(bw_g),title('end!');
% 
% hold on
% 
% for i = 1:col
%     %I�е�Ԫ��Ϊ��i��0��1
%     I = bw_g(:, i);
%     %�ж�a�Ƿ�Ϊ������ ���������Ƿ��з���Ԫ�� ������򷵻�1   255��
%     isZeros = any(I);
%     plot_x(i) = i;
%     if isZeros == 1
%         %yΪ��������ʾ�����ꣻxΪ��������ʾ������
%         [y, x] = find(I);
%          %%�������е�0��λ�ã�Ҳ������ֵ������
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
%             %����ֵ����λ��
%             maxlocal = 0;
%             %������ĸ�����ʱ�洢
%             tempcount = 0;
%             %������ĸ���
%             count = 1;
%             for j = 1: (zeros_amount-1)
%                 %��y(j+1)Ϊy(j)��һ�������ĵ㣬����+1
%                 if (y(j)==(y(j+1)-1))
%                     count = count + 1 ;
%                 %����Ͽ��ˣ�count��1
%                 else
%                     count = 1;
%                 end
%                 %�����������洢ֵ�ж�һ��
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
% Img=imageMat;      %��ȡͼ��
% 
% doubleImg = double(Img);     %ת����double����
% %greenIMG = doubleImg( : , : , 2);
% greenIMG = 2 * doubleImg( : , : , 1) - doubleImg( : , : , 2) - doubleImg( : , : , 3);
% greenIMG = 2  * greenIMG - min(min(greenIMG));
% %greenIMG = 255 * greenIMG / max(max(greenIMG));
% greenIMG = uint8(greenIMG);       %�޷����������ݣ�ȡֵ��Χ��0��255
% greenthresh = graythresh(greenIMG);     %graythresh��һ��������������ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ�����������ֵͨ������Ϊ�趨����ֵ�ܸ��õذ�һ�ŻҶ�ͼ��ת��Ϊ��ֵͼ��
% IMGbw = im2bw( greenIMG , greenthresh);    %im2bwʹ����ֵ��threshold���任���ѻҶ�ͼ��grayscale image��ת���ɶ�ֵͼ��
% B3=imcomplement(IMGbw);
% IMGbw1 = IMGbw;
% IMGbw1 =B3;
% %������������
% [row, col] = size(IMGbw1);
% plot_x = [];      %��¼����λ�õĺ�����
% plot_y = [];      %��¼����λ�õ�������
% % figure, imshow(numIMG),title('end!');
% %  %figure, imshow(IMGbw),title('end!');
% %   %figure, imshow(greenIMG),title('end!');
% %  
% % hold on
% for i = 1:col
%     I = IMGbw1(:, i);%I�е�Ԫ��Ϊ��i�ĻҶ�ֵ
%     isZeros = any(I);%�ж�a�Ƿ�Ϊ������ ���������Ƿ��з���Ԫ�� ������򷵻�1   255��
%     if isZeros == 1
%         [y, x] = find(I);%yΪ��������ʾ�����ꣻxΪ��������ʾ������
%         zero_index = y;              %%�������е�0��λ�ã�Ҳ������ֵ������
%         zeros_amount = length(zero_index);
%         if ((sum(y) == (y(1)*2+zeros_amount-1)*zeros_amount/2))
%             colGrayNum = greenIMG(y);
%             colGrayNumSum = sum(colGrayNum);
%             colcentroid = double(colGrayNum).* double(y);
%             
%             plot_x(i) = [plot_x i];
%             plot_y(i) = [plot_y sum(colcentroid) / colGrayNumSum];
% %             plot(plot_x(i), plot_y(i), 'red.');����ʹ��������������ʽ�����Բ���plot��
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
Img=imageMat;      %��ȡͼ��

doubleImg = double(Img);     %ת����double����
%greenIMG = doubleImg( : , : , 2);
greenIMG = 2 * doubleImg( : , : , 1) - doubleImg( : , : , 2) - doubleImg( : , : , 3);
greenIMG = 2  * greenIMG - min(min(greenIMG));
%greenIMG = 255 * greenIMG / max(max(greenIMG));
greenIMG = uint8(greenIMG);       %�޷����������ݣ�ȡֵ��Χ��0��255
greenthresh = graythresh(greenIMG);     %graythresh��һ��������������ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ�����������ֵͨ������Ϊ�趨����ֵ�ܸ��õذ�һ�ŻҶ�ͼ��ת��Ϊ��ֵͼ��
IMGbw = im2bw( greenIMG , greenthresh);    %im2bwʹ����ֵ��threshold���任���ѻҶ�ͼ��grayscale image��ת���ɶ�ֵͼ��
IMGbw = bwareaopen(IMGbw,200,4);
B3=imcomplement(IMGbw);
IMGbw1 = IMGbw;
IMGbw1 =B3;
%������������
[row, col] = size(IMGbw1);
%plot_x = zeros(1,col);      %��¼����λ�õĺ�����
%plot_y = zeros(1,col);      %��¼����λ�õ�������
%figure, imshow(numIMG),title('end!');
plot_x = [];
plot_y = [];
 %figure, imshow(IMGbw),title('end!');
  %figure, imshow(greenIMG),title('end!');
 
%hold on
for i = 1:col
    I = IMGbw1(:, i);%I�е�Ԫ��Ϊ��i�ĻҶ�ֵ
    isZeros = any(I);%�ж�a�Ƿ�Ϊ������ ���������Ƿ��з���Ԫ�� ������򷵻�1   255��
    if isZeros == 1
        [y, x] = find(I);%yΪ��������ʾ�����ꣻxΪ��������ʾ������
        zero_index = y;              %%�������е�0��λ�ã�Ҳ������ֵ������
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

