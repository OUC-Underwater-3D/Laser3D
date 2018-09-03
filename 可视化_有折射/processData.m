%2017.12.26�޸�
%% �������ݣ��޷���ֵ
function processData(folder_path, num1, num2, prefix, suffix, f_1, f_2, cc_1, cc_2, para)
%��ȡͼƬ����
num1 = str2num(num1);
num2 = str2num(num2);
%����һ���������ڴ�����е�ͼƬ
matrix_all = [];
%����һ����������չʾ
display_figure = figure;
display_ax = axes(display_figure);
image_figure = figure;
image_ax = axes(image_figure);
set(display_ax,'NextPlot','add');
xlabel(display_ax,'x');
ylabel(display_ax,'y');
colormap(display_ax,'jet');
%��ֹ�رճ���-�۽���ǰ����
%set(display_figure, 'windowstyle','modal');

%��ʾ��ͬʱҲ��ʼд���ļ�
%dataFilePath = [folder_path, '\data.ply'];
%fid = fopen(dataFilePath, 'wt');
%fprintf(fid, '%s\n', 'ply');
%fprintf(fid, '%s\n', 'format ascii 1.0');
%fprintf(fid, '%s\n', ['element vertex ',num2str(row_num)]);
%%����ñ���ȫ��Ȼ����д�룬��Ϊ��Ҫrow_num
%fprintf(fid, '%s\n', 'property float x');
%fprintf(fid, '%s\n', 'property float y');
%fprintf(fid, '%s\n', 'property float z');
%fprintf(fid, '%s\n', 'end_header');
%currentNum = num1;
for number = num1:num2
    %ƴ��·��(�ļ���·��+ͼƬ)
    imageName = strcat([folder_path, '\', prefix] ,num2str(number), ['.', suffix]);
    %��ȡ�����
    if exist(imageName, 'file')~=0
        %currentNum = currentNum + 1;
        imageMat = imread(imageName);
        [x_matrix, y_matrix] = findLaserPoint(imageMat);
        %����
        [X_c, Y_c, Z_c] = getLaserH(x_matrix, y_matrix, f_1, f_2, cc_1, cc_2, para);
        %�������ٶ�ֵ����Ҫ����ʵ�ʲ�����ã�
        Y_c = Y_c - 3.125*number;
%         r = sqrt(power(Z_c,2)+power(Y_c,2));
%         Z_c = r * sin(pi/4);
%         Y_c = Y_c + r * cos(pi/4);
        %����ͼ��ľ���
        matrix_temp = [Y_c(:) X_c(:) Z_c(:)];
%         matrix_temp2 = [x_matrix(:) y_matrix(:)];
        %aver=-117.2;
    
        %ȥ����ֵ
%     matrix_new=[];
%     for row=1:size(matrix_temp,1)
%         row_vector=matrix_temp(row,:);
%         if norm(row_vector)>0
%             matrix_new=[matrix_new;row_vector];
%         end
%     end
        matrix_all = [matrix_all; matrix_temp];
%         matrix_all2 = [matrix_all2; matrix_temp2];
        %��ֹ�رպ󵯳��´���
        uicontrol(display_figure, 'Style', 'text', 'String', 'ɨ����');
        %showPointCloud(matrix_temp);
        %��ʾͼ��

    
        imshow(imageMat, 'Parent', image_ax);
        pcshow(matrix_temp,'Parent',display_ax);
        %xlim(display_ax,[-150,150]); 
        %ylim(display_ax,[100,300]);
        zlim(display_ax,[-150,100]);
        pause(0.1);
        %fprintf(fid, '%.4f %.4f %.4f\n', matrix_temp');
    end
end
%fclose(fid);
%msgbox(dataFilePath, '�ļ�д��ɹ�', 'warn')
%clear matrix_all;
%clear matrix_temp;
%%
%д���ļ����ǲ���Ҫ��ͼƬд�룿--û�а취��֤д���˳�򣬲�֪��MATLAB�ǲ��Ƕ��̵߳�
[row_num,col_num] = size(matrix_all(:,1));
disp(row_num);
disp(col_num);
dataFilePath = [folder_path, '\data.ply'];
fid = fopen(dataFilePath, 'wt');
fprintf(fid, '%s\n', 'ply');
fprintf(fid, '%s\n', 'format ascii 1.0');
fprintf(fid, '%s\n', ['element vertex ',num2str(row_num)]);
fprintf(fid, '%s\n', 'property float x');
fprintf(fid, '%s\n', 'property float y');
fprintf(fid, '%s\n', 'property float z');
fprintf(fid, '%s\n', 'end_header');
fprintf(fid, '%.4f %.4f %.4f\n', matrix_all');
fclose(fid);
msgbox(dataFilePath, '�ļ�д��ɹ�', 'warn')
clear matrix_all;
clear matrix_temp;


% [row_num2,col_num2] = size(matrix_all2(:,1));
% disp(row_num2);
% disp(col_num2);
% dataFilePath = [folder_path, '\data2.ply'];
% fid2 = fopen(dataFilePath, 'wt');
% fprintf(fid2, '%s\n', 'ply');
% fprintf(fid2, '%s\n', 'format ascii 1.0');
% fprintf(fid2, '%s\n', ['element vertex ',num2str(row_num2)]);
% fprintf(fid2, '%s\n', 'property float x');
% fprintf(fid2, '%s\n', 'property float y');
% fprintf(fid2, '%s\n', 'end_header');
% fprintf(fid2, '%.4f %.4f \n', matrix_all2');
% fclose(fid2);
% msgbox(dataFilePath, '�ļ�д��ɹ�', 'warn')
% clear matrix_all2;
% clear matrix_temp2;
end



