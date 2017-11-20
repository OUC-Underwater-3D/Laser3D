load calibrationSession;
%load Calib_Results;
intrinsic = calibrationSession.CameraParameters.IntrinsicMatrix;
inter=intrinsic';
[p_temp,img_num]=Uw3D_GetPoint;
point_num =img_num*2;
p = zeros(3,point_num);
Loc = [];
j=1;
for i=1:point_num
p(:,i) = [p_temp(i,1);p_temp(i,2);1];
    %Rc=eval(['Rc_',num2str(j)]);
    %Tc=eval(['Tc_',num2str(j)]);
    Rc= calibrationSession.CameraParameters.RotationMatrices(:,:,j);
    Rc(:,[1;2])=Rc(:,[2;1]);
    Rc(3,:)=-Rc(3,:);
    Tc= calibrationSession.CameraParameters.TranslationVectors(j,:);
    Tc=Tc';
        if  mod(i,2)==0
        j=j+1;
    end
temp = Uw3D_Laser(p(:,i), inter, Rc, Tc);
Loc = [Loc temp];
end

X = Loc(1,:);
Y = Loc(2,:);
Z = Loc(3,:);

xyz = [ones(point_num,1) X' Y'];
para = regress(Z', xyz)
xfit = min(X):1:max(X);  
yfit = min(Y):1:max(Y);

[XFIT,YFIT]= meshgrid(xfit,yfit); 
ZFIT = para(1) + para(2) * XFIT + para(3) * YFIT;

figure, plot3(X,Y,Z,'o');
hold on;
axis equal;
mesh(XFIT,YFIT,ZFIT);
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on;
hold off;

