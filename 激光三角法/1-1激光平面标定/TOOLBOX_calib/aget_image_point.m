function [p_cam,img_num] = aget_image_point( )
flag=1;
p_cam=[];
file_path='D:\Matlab\TOOLBOX_calib\';     
img_path_list=dir(strcat(file_path,'c_rect*.BMP'));
img_num=length(img_path_list);
   for id =1:img_num
       idpath = sprintf('c_rect%d.BMP',id);
       image = imread(idpath);
       figure,imshow(image);
    [x,y]=getpts();
    temp=[x,y];
    i=temp(:,1);
    j=temp(:,2);
    hold on
    M=plot(i,j,'r-o');
    pause()
    while(strcmpi(get(gcf,'CurrentCharacter'),'e'))
            delete(M);
            hold on
            [x,y]=getpts();
             temp=[x,y];
             i=temp(:,1);
             j=temp(:,2);
             hold on
             M=plot(i,j,'r-o');
             pause()
    end
        flag=flag+1;
        p_cam=[p_cam;temp];
        %close(figure(gcf));
end



