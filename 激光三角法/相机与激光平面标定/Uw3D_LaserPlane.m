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
        %���ú���Uw3D_Laser�󼤹�ƽ���
        Laser_point_save = [Laser_point_save Laser_point];
    end
    x=x+point_per_image(j);
 end
    Laser_point_X = Laser_point_save(1,:);
    %Laser_point_save�ĵ�һ�и�ֵ��X��X�������������ϵ��x�ĺϼ�
    Laser_point_Y = Laser_point_save(2,:);
    Laser_point_Z = Laser_point_save(3,:);%��λmm
    Temporary_value = [ones(click_point_number,1) Laser_point_X' Laser_point_Y'];
    %Temporary_value��ʱ����
    para = regress(Laser_point_Z',Temporary_value);
    %regress�������ع�����������о����ֱ���֮��Ĺ�ϵ��
    %para����ϳ�������������A,B,C
    Variation_range_x = min(Laser_point_X):1:max(Laser_point_X);
    %Variation_range_x��min(Laser_point_X)��ʼÿ����1ֱ��max(Laser_point_X)
    Variation_range_y = min(Laser_point_Y):1:max(Laser_point_Y);
    [XFIT,YFIT]= meshgrid(Variation_range_x,Variation_range_y);
    %meshgrid��������һ����ά����ƽ��
    %���XFIT��ÿһ�е���ֵ���Ǹ��Ƶ�Variation_range_x��ֵ��
    %���YFIT��ÿһ�е���ֵ���Ǹ��Ƶ�Variation_range_y��ֵ��
    ZFIT = para(1) + para(2) * XFIT + para(3) * YFIT;
    %����para�õ��Ĳ�����ZFIT
    %��ͼ���ڲ鿴��Ͻ��
    figure, plot3(Laser_point_X,Laser_point_Y,Laser_point_Z,'.');
    %������X,Y,ZΪx,y,z�������ά����
    hold on;
    axis equal;%ʹ��������ÿ�������ϵĵ�λ������ͬ
    mesh(XFIT,YFIT,ZFIT);%��XFIT,YFIT,ZFITΪ�Ա�����������ͼ
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    grid on;
    hold off;
end