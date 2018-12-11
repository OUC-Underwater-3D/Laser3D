function [CLICK_point_save,image_number,click_point_number,point_per_image] = Uw3D_GetPoints()
load calibrationSession;
[aftercorrect,imageFileNames]=Uw3D_PhotoCorrect( );
image_number=length(imageFileNames);
point_per_image=zeros(image_number,1);
for ip=1:image_number
    %mindimension(:,:)=aftercorrect(ip,:,:);
    str='c.bmp';
    a=[num2str(ip),str];
    imwrite(aftercorrect(:,:,:,ip),a);
    %imwrite(mindimension,a);
end
thispath=pwd;
diagonal='\';
InputDir=strcat(thispath,diagonal);
CLICK_point_save=[];
for id =1:image_number
    click_point_save=[];
    bgFile = [InputDir,num2str(id),'c.bmp'];
    Background = imread(bgFile);
    %有四个点，确定一个范围，在这个范围上寻找合适的点
    fourpoint=calibrationSession.BoardSet.BoardPoints(:,:,id);
    A=fourpoint(1,:);
    B=fourpoint(81,:);
    C=fourpoint(88,:);
    D=fourpoint(8,:);
    db_Background = double(Background);     %转换成double类型
    G_channel = 2 * db_Background( : , : , 1) - db_Background( : , : , 2) - db_Background( : , : , 3);
    G_channel = 2*G_channel - min(min(G_channel));
    %g = 255 * g / max(max(g));
    G_channel = uint8(G_channel);       %无符号整形数据，取值范围从0到255
    % gh = graythresh(g);     %graythresh是一个函数，功能是使用最大类间方差法找到图片的一个合适的阈值。利用这个阈值通常比人为设定的阈值能更好地把一张灰度图像转换为二值图像
    Binary_image = im2bw( G_channel , 0.4);    %im2bw使用阈值（threshold）变换法把灰度图像（grayscale image）转换成二值图像。
    %%%%%%%%%%%%%%%%%%%%%在这里做阈值分割
    invert_colors=  imcomplement(Binary_image);   
    invert_colors = imfill(invert_colors,'holes');
    Binary_image = bwareaopen(invert_colors,400,4);
    threshold = Binary_image;
    bwImage = threshold;
    [row, col] = size(bwImage);
    plot_x = zeros(1,col);
    %记录质心位置的横坐标
    plot_y = zeros(1,col);
    %记录质心位置的纵坐标
    
    for i = 1:col
        I = bwImage(:, i);
        %I中的元素为第i列的灰度值
        isNonZeros = any(I);
        %判断a是否为非零向量
        if isNonZeros == 1
            [yy, xx] = find(I);
            %y为行数，表示纵坐标；x为列数，表示横坐标
            [count, ~] = size(yy);
            %count表示坐标的个数
            sum_y = sum(yy);
            %纵坐标的和
            plot_x(i) = i;
            plot_y(i) = sum_y / count;
            %质心公式
            x=plot_x(i);
            y=plot_y(i);
            
            %判断点是否在四边形内，如果在，写入loc
            a=(B(1)-A(1))*(y-A(2))-(B(2)-A(2))*(x-A(1));
            b=(C(1)-B(1))*(y-B(2))-(C(2)-B(2))*(x-B(1));
            c=(D(1)-C(1))*(y-C(2))-(D(2)-C(2))*(x-C(1));
            d=(A(1)-D(1))*(y-D(2))-(A(2)-D(2))*(x-D(1));
            if ((a > 0 && b > 0 && c > 0 && d > 0) || (a < 0 && b < 0 && c < 0 && d < 0))
                %%%%%%%%%%质心法,在四边形内做处理
                Loc=[x,y];
                click_point_save=[click_point_save;Loc];
                
            end
        end
    end
    %%%是否显示出激光线上的点
    figure(id),imshow(Background);
    hold on
    plot(click_point_save(:,1),click_point_save(:,2),'r.');
    
    point_per_image(id,1)=size(click_point_save,1);
    CLICK_point_save=[CLICK_point_save;click_point_save];
end
click_point_number=size(CLICK_point_save,1);
end