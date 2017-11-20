function [p_cam,img_num] = Uw3D_GetPoint( )
flag=1;
p_cam=[];
[aftercorrect,imageFileNames]=Uw3D_PhotoCorrect( );
img_num=length(imageFileNames);
for ip=1:img_num
  mindimension(:,:)=aftercorrect(ip,:,:);
imwrite( mindimension,strcat('C_cret',num2str(ip),'.BMP')); 
end
   for id =1:img_num
       idpath = sprintf('C_cret%d.BMP',id);
       image = imread(idpath);
      hFig=figure('Toolbar','none','Menubar','none');
      hIm=imshow(image);
      hSP=imscrollpanel(hFig,hIm);
      api=iptgetapi(hSP);
      api.setMagnification(1.5);
      imoverview(hIm);
      %figure,imshow(image);
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
       % close(figure(gcf));
end