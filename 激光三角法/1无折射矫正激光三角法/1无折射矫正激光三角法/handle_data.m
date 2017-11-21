function [matrix_new] = handle(path,amount,start_tag,extension)
clear cll;
g_src = '.\';  %所需要处理的图片所在文件目录


get_handle_image_nums = str2num(amount);
%Data = cell(1,get_handle_image_nums);
matrix = [];

for i=1:get_handle_image_nums
    image_name=strcat('\',start_tag,num2str(i),'.',extension);
    src = [g_src, image_name];
    %src = [g_src, 'cc3_rect.bmp']; 
    model = 2;
    [realHeight, mask1] = getLaserHeight(src, model);
    x = realHeight.x;
    y = realHeight.y;
    z = realHeight.z;
%     figure;
%     mesh(x,y,z);
%     size(x)    %900*1200
    matrix1 = [x(:) y(:) z(:)];
    matrix = [matrix ;matrix1]; %组合多幅图像为一个大的矩阵

end
%去除零值
matrix_new=[];
    for row=1:size(matrix,1)
        row_vector=matrix(row,:);
        if norm(row_vector)>0
            matrix_new=[matrix_new;row_vector];
            disp(row_vector)
        end
    end
end

