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

