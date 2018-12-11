function World_point = Uw3D_Laser(point, intrinsic, RotationMatrix,TranslationMatrix)
%第一步：把像素坐标转换到归一化图像坐标
normalization_x = (point(1)-intrinsic(1,3))/intrinsic(1,1);%归一化平面上的点
%point(1)点的x坐标，intrinsic(1,1)焦距x坐标，intrinsic(1,3)主点x坐标
normalization_y = (point(2)-intrinsic(2,3))/intrinsic(2,2);
%point(2)点的y坐标，intrinsic(2,2)焦距y坐标，intrinsic(2,3)主点y坐标
%第二步：求标定平面的方程
RotationMatrix = pinv(RotationMatrix);
%激光平面方程Ax+By+Cz+D=0
A=RotationMatrix(3,1);
B=RotationMatrix(3,2);
C=RotationMatrix(3,3);
%激光平面方程的系数D
D = TranslationMatrix(1)*A+ TranslationMatrix(2)*B+ TranslationMatrix(3)*C;
World_point_z = D/(A*normalization_x+B*normalization_y+C);
World_point_x=World_point_z*normalization_x;
World_point_y=World_point_z*normalization_y;
World_point = [World_point_x; World_point_y; World_point_z];
%world存储的是世界坐标点p2（x，y，z）
%在选的点中随机抽样rannsac