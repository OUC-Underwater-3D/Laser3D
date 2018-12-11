%% �������ݣ��޷���ֵ���������ļ���·����ͼƬ������ǰ׺����׺����չ���������������
function processData(folder_path, num1, num2, prefix, suffix, f_1, f_2, cc_1, cc_2, para)
%��ȡͼƬ����
num1 = str2num(num1);
num2 = str2num(num2);
%����һ���������ڴ�����е�ͼƬ
matrix_all = [];
matrix_all2= [];
%����һ����������չʾ����
display_figure = figure;
%��ȡ����ϵ
display_ax = axes(display_figure);
%����һ����������չʾͼ��
image_figure = figure;
%��ȡ����ϵ
image_ax = axes(image_figure);
%��add����ʽ��̬׷�ӵ���
set(display_ax,'NextPlot','add');
xlabel(display_ax,'x');
ylabel(display_ax,'y');
%������ɫ
colormap(display_ax,'jet');
%��ֹ�رճ���-�۽���ǰ����
%set(display_figure, 'windowstyle','modal');
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
        matrix_temp = [X_c(:) Y_c(:) Z_c(:)];
        matrix_all = [matrix_all; matrix_temp];
        imshow(imageMat, 'Parent', image_ax);
        pcshow(matrix_temp,'Parent',display_ax);
        %xlim(display_ax,[-150,150]); 
        %ylim(display_ax,[100,300]);
        %zlim(display_ax,[-150,0]);
        pause(0.1);
    end
end
%%
%д���ļ���û�а취����д�룬ֻ�ܶ�����д���ļ�����ΪҪͳ�Ƶ�ĸ����������ļ�ͷ��������
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
end



