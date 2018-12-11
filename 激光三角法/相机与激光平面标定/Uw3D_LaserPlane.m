function para=Uw3D_LaserPlane()
    close all;    
    load calibrationSession;
    intrinsic = calibrationSession.CameraParameters.IntrinsicMatrix;
    intrinsic = intrinsic';
    [click_point_save,image_number,click_point_number,point_per_image] = Uw3D_GetPoints();
    point = zeros(3, click_point_number);
    Laser_point_save = [];
    x=1;
    point_sum=0;
    for j=1:image_number
    point_sum=point_sum+point_per_image(j);
    for i=x:point_sum
        point(:,i) = [click_point_save(i,1);click_point_save(i,2);1];
        RotationMatrix= calibrationSession.CameraParameters.RotationMatrices(:,:,j);
        RotationMatrix(:,[1;2])=RotationMatrix(:,[2;1]);
        RotationMatrix(3,:)=-RotationMatrix(3,:);
        TranslationMatrix= calibrationSession.CameraParameters.TranslationVectors(j,:);
        TranslationMatrix=TranslationMatrix';
        Laser_point = Uw3D_Laser(point(:,i), intrinsic, RotationMatrix, TranslationMatrix);
        %调用函数Uw3D_Laser求激光平面点
        Laser_point_save = [Laser_point_save Laser_point];
    end
    x=x+point_per_image(j);
 end
    Laser_point_X = Laser_point_save(1,:);
    %Laser_point_save的第一行赋值给X，X是所有相机坐标系点x的合集
    Laser_point_Y = Laser_point_save(2,:);
    Laser_point_Z = Laser_point_save(3,:);%单位mm
    Temporary_value = [ones(click_point_number,1) Laser_point_X' Laser_point_Y'];
    %Temporary_value临时变量
    para = regress(Laser_point_Z',Temporary_value);
    %regress函数，回归分析，就是研究几种变量之间的关系。
    %para是拟合出的三个参数，A,B,C
    Variation_range_x = min(Laser_point_X):1:max(Laser_point_X);
    %Variation_range_x从min(Laser_point_X)开始每增加1直到max(Laser_point_X)
    Variation_range_y = min(Laser_point_Y):1:max(Laser_point_Y);
    [XFIT,YFIT]= meshgrid(Variation_range_x,Variation_range_y);
    %meshgrid生成生成一个二维网格平面
    %输出XFIT的每一行的数值都是复制的Variation_range_x的值；
    %输出YFIT的每一列的数值都是复制的Variation_range_y的值；
    ZFIT = para(1) + para(2) * XFIT + para(3) * YFIT;
    %利用para得到的参数求ZFIT
    %绘图用于查看拟合结果
    figure, plot3(Laser_point_X,Laser_point_Y,Laser_point_Z,'.');
    %绘制以X,Y,Z为x,y,z坐标的三维曲线
    hold on;
    axis equal;%使得坐标轴每个方向上的单位长度相同
    mesh(XFIT,YFIT,ZFIT);%以XFIT,YFIT,ZFIT为自变量绘制网格图
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    grid on;
    hold off;
end