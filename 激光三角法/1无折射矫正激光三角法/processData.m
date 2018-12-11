%% 处理数据，无返回值，参数（文件夹路径，图片数量，前缀，后缀【扩展名】，相机参数）
function processData(folder_path, num1, num2, prefix, suffix, f_1, f_2, cc_1, cc_2, para)
%获取图片数量
num1 = str2num(num1);
num2 = str2num(num2);
%声明一个矩阵，用于存放所有的图片
matrix_all = [];
matrix_all2= [];
%声明一个窗口用于展示点云
display_figure = figure;
%获取坐标系
display_ax = axes(display_figure);
%声明一个窗口用于展示图像
image_figure = figure;
%获取坐标系
image_ax = axes(image_figure);
%以add的形式动态追加点云
set(display_ax,'NextPlot','add');
xlabel(display_ax,'x');
ylabel(display_ax,'y');
%设置颜色
colormap(display_ax,'jet');
%防止关闭出错-聚焦当前窗口
%set(display_figure, 'windowstyle','modal');
for number = num1:num2
    %拼接路径(文件夹路径+图片)
    imageName = strcat([folder_path, '\', prefix] ,num2str(number), ['.', suffix]);
    %获取激光点
    if exist(imageName, 'file')~=0
        %currentNum = currentNum + 1;
        imageMat = imread(imageName);
        [x_matrix, y_matrix] = findLaserPoint(imageMat);
        %计算
        [X_c, Y_c, Z_c] = getLaserH(x_matrix, y_matrix, f_1, f_2, cc_1, cc_2, para);
        %随便给的速度值（需要根据实际测量获得）
        Y_c = Y_c - 3.125*number;
%         r = sqrt(power(Z_c,2)+power(Y_c,2));
%         Z_c = r * sin(pi/4);
%         Y_c = Y_c + r * cos(pi/4);
        %单幅图像的矩阵
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
%写入文件，没有办法分批写入，只能读完了写入文件，因为要统计点的个数并且在文件头进行声明
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
msgbox(dataFilePath, '文件写入成功', 'warn')
clear matrix_all;
clear matrix_temp;
end



