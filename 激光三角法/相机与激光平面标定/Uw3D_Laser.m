function World_point = Uw3D_Laser(point, intrinsic, RotationMatrix,TranslationMatrix)
%��һ��������������ת������һ��ͼ������
normalization_x = (point(1)-intrinsic(1,3))/intrinsic(1,1);%��һ��ƽ���ϵĵ�
%point(1)���x���꣬intrinsic(1,1)����x���꣬intrinsic(1,3)����x����
normalization_y = (point(2)-intrinsic(2,3))/intrinsic(2,2);
%point(2)���y���꣬intrinsic(2,2)����y���꣬intrinsic(2,3)����y����
%�ڶ�������궨ƽ��ķ���
RotationMatrix = pinv(RotationMatrix);
%����ƽ�淽��Ax+By+Cz+D=0
A=RotationMatrix(3,1);
B=RotationMatrix(3,2);
C=RotationMatrix(3,3);
%����ƽ�淽�̵�ϵ��D
D = TranslationMatrix(1)*A+ TranslationMatrix(2)*B+ TranslationMatrix(3)*C;
World_point_z = D/(A*normalization_x+B*normalization_y+C);
World_point_x=World_point_z*normalization_x;
World_point_y=World_point_z*normalization_y;
World_point = [World_point_x; World_point_y; World_point_z];
%world�洢�������������p2��x��y��z��
%��ѡ�ĵ����������rannsac