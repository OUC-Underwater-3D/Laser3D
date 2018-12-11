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
    %���ĸ��㣬ȷ��һ����Χ���������Χ��Ѱ�Һ��ʵĵ�
    fourpoint=calibrationSession.BoardSet.BoardPoints(:,:,id);
    A=fourpoint(1,:);
    B=fourpoint(81,:);
    C=fourpoint(88,:);
    D=fourpoint(8,:);
    db_Background = double(Background);     %ת����double����
    G_channel = 2 * db_Background( : , : , 1) - db_Background( : , : , 2) - db_Background( : , : , 3);
    G_channel = 2*G_channel - min(min(G_channel));
    %g = 255 * g / max(max(g));
    G_channel = uint8(G_channel);       %�޷����������ݣ�ȡֵ��Χ��0��255
    % gh = graythresh(g);     %graythresh��һ��������������ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ�����������ֵͨ������Ϊ�趨����ֵ�ܸ��õذ�һ�ŻҶ�ͼ��ת��Ϊ��ֵͼ��
    Binary_image = im2bw( G_channel , 0.4);    %im2bwʹ����ֵ��threshold���任���ѻҶ�ͼ��grayscale image��ת���ɶ�ֵͼ��
    %%%%%%%%%%%%%%%%%%%%%����������ֵ�ָ�
    invert_colors=  imcomplement(Binary_image);   
    invert_colors = imfill(invert_colors,'holes');
    Binary_image = bwareaopen(invert_colors,400,4);
    threshold = Binary_image;
    bwImage = threshold;
    [row, col] = size(bwImage);
    plot_x = zeros(1,col);
    %��¼����λ�õĺ�����
    plot_y = zeros(1,col);
    %��¼����λ�õ�������
    
    for i = 1:col
        I = bwImage(:, i);
        %I�е�Ԫ��Ϊ��i�еĻҶ�ֵ
        isNonZeros = any(I);
        %�ж�a�Ƿ�Ϊ��������
        if isNonZeros == 1
            [yy, xx] = find(I);
            %yΪ��������ʾ�����ꣻxΪ��������ʾ������
            [count, ~] = size(yy);
            %count��ʾ����ĸ���
            sum_y = sum(yy);
            %������ĺ�
            plot_x(i) = i;
            plot_y(i) = sum_y / count;
            %���Ĺ�ʽ
            x=plot_x(i);
            y=plot_y(i);
            
            %�жϵ��Ƿ����ı����ڣ�����ڣ�д��loc
            a=(B(1)-A(1))*(y-A(2))-(B(2)-A(2))*(x-A(1));
            b=(C(1)-B(1))*(y-B(2))-(C(2)-B(2))*(x-B(1));
            c=(D(1)-C(1))*(y-C(2))-(D(2)-C(2))*(x-C(1));
            d=(A(1)-D(1))*(y-D(2))-(A(2)-D(2))*(x-D(1));
            if ((a > 0 && b > 0 && c > 0 && d > 0) || (a < 0 && b < 0 && c < 0 && d < 0))
                %%%%%%%%%%���ķ�,���ı�����������
                Loc=[x,y];
                click_point_save=[click_point_save;Loc];
                
            end
        end
    end
    %%%�Ƿ���ʾ���������ϵĵ�
    figure(id),imshow(Background);
    hold on
    plot(click_point_save(:,1),click_point_save(:,2),'r.');
    
    point_per_image(id,1)=size(click_point_save,1);
    CLICK_point_save=[CLICK_point_save;click_point_save];
end
click_point_number=size(CLICK_point_save,1);
end