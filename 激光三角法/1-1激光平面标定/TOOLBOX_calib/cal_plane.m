%written by wangnan
%2017.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Loc_laser = [0 350 0]';
unit = 22.66;
point_num = 40;
p = zeros(4,point_num);
Loc = [];
p(:,1) = [0 unit*2/3 0 1]';
Loc = [Loc [Rc_1 Tc_1]*p(:,1)];

p(:,2) = [unit*8 unit*3/4 0 1]';
Loc = [Loc [Rc_1 Tc_1]*p(:,2)];

p(:,3) = [unit*9 unit*2 0 1]';
Loc = [Loc [Rc_2 Tc_2]*p(:,3)];

p(:,4) = [unit*3 unit*1.5 0 1]';
Loc = [Loc [Rc_2 Tc_2]*p(:,4)];

p(:,5) = [unit*4 unit 0 1]';
Loc = [Loc [Rc_3 Tc_3]*p(:,5)];

p(:,6) = [0 unit*9/10 0 1]';
Loc = [Loc [Rc_3 Tc_3]*p(:,6)];

p(:,7) = [unit*5 unit*2 0 1]';
Loc = [Loc [Rc_4 Tc_4]*p(:,7)];

p(:,8) = [unit*9 unit*3.5 0 1]';
Loc = [Loc [Rc_4 Tc_4]*p(:,8)];

p(:,9) = [0 unit*1.5 0 1]';
Loc = [Loc [Rc_5 Tc_5]*p(:,9)];

p(:,10) = [unit*10 unit*7/4 0 1]';
Loc = [Loc [Rc_5 Tc_5]*p(:,10)];

p(:,11) = [unit*7 unit*2 0 1]';
Loc = [Loc [Rc_6 Tc_6]*p(:,11)];

p(:,12) = [unit*4.5 unit*1.5 0 1]';
Loc = [Loc [Rc_6 Tc_6]*p(:,12)];

p(:,13) = [unit*6 unit*2.5 0 1]';
Loc = [Loc [Rc_7 Tc_7]*p(:,13)];

p(:,14) = [unit*0.5 unit*1.5 0 1]';
Loc = [Loc [Rc_7 Tc_7]*p(:,14)];

p(:,15) = [unit*6 unit*2 0 1]';
Loc = [Loc [Rc_8 Tc_8]*p(:,15)];

p(:,16) = [unit*10 unit*7/4 0 1]';
Loc = [Loc [Rc_8 Tc_8]*p(:,16)];

p(:,17) = [0 unit*2.5 0 1]';
Loc = [Loc [Rc_9 Tc_9]*p(:,17)];

p(:,18) = [unit*2 unit*3 0 1]';
Loc = [Loc [Rc_9 Tc_9]*p(:,18)];

p(:,19) = [unit*7 unit*2 0 1]';
Loc = [Loc [Rc_10 Tc_10]*p(:,19)];

p(:,20) = [unit*4 unit*2.5 0 1]';
Loc = [Loc [Rc_10 Tc_10]*p(:,20)];

p(:,21) = [unit*8 unit*2.5 0 1]';
Loc = [Loc [Rc_11 Tc_11]*p(:,21)];

p(:,22) = [unit*5 unit*7/3 0 1]';
Loc = [Loc [Rc_11 Tc_11]*p(:,22)];

p(:,23) = [unit*6 unit*3 0 1]';
Loc = [Loc [Rc_12 Tc_12]*p(:,23)];

p(:,24) = [unit*10 unit*13/4 0 1]';
Loc = [Loc [Rc_12 Tc_12]*p(:,24)];

p(:,25) = [unit*4 unit*4 0 1]';
Loc = [Loc [Rc_13 Tc_13]*p(:,25)];

p(:,26) = [unit*1.5 unit 0 1]';
Loc = [Loc [Rc_13 Tc_13]*p(:,26)];

p(:,27) = [unit*4.5 unit*4 0 1]';
Loc = [Loc [Rc_14 Tc_14]*p(:,27)];

p(:,28) = [unit*5.5 unit*5.5 0 1]';
Loc = [Loc [Rc_14 Tc_14]*p(:,28)];

p(:,29) = [unit*6 unit*4 0 1]';
Loc = [Loc [Rc_15 Tc_15]*p(:,29)];

p(:,30) = [unit*9.5 unit*7 0 1]';
Loc = [Loc [Rc_15 Tc_15]*p(:,30)];

p(:,31) = [unit*4 unit*4 0 1]';
Loc = [Loc [Rc_16 Tc_16]*p(:,31)];

p(:,32) = [unit*5.5 unit*6 0 1]';
Loc = [Loc [Rc_16 Tc_16]*p(:,32)];

p(:,33) = [unit*6 unit*3 0 1]';
Loc = [Loc [Rc_17 Tc_17]*p(:,33)];

p(:,34) = [unit*6.5 unit*6 0 1]';
Loc = [Loc [Rc_17 Tc_17]*p(:,34)];

p(:,35) = [unit*6. unit*3 0 1]';
Loc = [Loc [Rc_18 Tc_18]*p(:,35)];

p(:,36) = [unit*6.5 unit*6 0 1]';
Loc = [Loc [Rc_18 Tc_18]*p(:,36)];

p(:,37) = [unit*4 unit*4 0 1]';
Loc = [Loc [Rc_19 Tc_19]*p(:,37)];

p(:,38) = [unit*4.5 unit*3 0 1]';
Loc = [Loc [Rc_19 Tc_19]*p(:,38)];

p(:,39) = [unit*5.5 unit*7 0 1]';
Loc = [Loc [Rc_20 Tc_20]*p(:,39)];

p(:,40) = [unit*16/3 unit*4 0 1]';
Loc = [Loc [Rc_20 Tc_20]*p(:,40)];

X = [Loc_laser(1) Loc(1,:)];
Y = [Loc_laser(2) Loc(2,:)];
Z = [Loc_laser(3) Loc(3,:)];
figure, plot3(X,Y,Z,'o');
hold on;
plot3(0,0,0,'.r','markersize',16)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on

xyz = [ones(point_num+1,1) X' Y'];
para = regress(Z', xyz)

xfit = min(X):0.1:max(X);  
yfit = min(Y):0.1:max(Y);
[XFIT,YFIT]= meshgrid (xfit,yfit); 
ZFIT = para(1) + para(2) * XFIT + para(3) * YFIT;
figure, mesh(XFIT,YFIT,ZFIT);

% 
% iteration = 100;
% cost_sum_min = 1e10; 
% for i = 1:iteration
% 	index = randperm(point_num+1,3);
% 	loc1 = Loc(:,index(1));
% 	loc2 = Loc(:,index(2));
% 	loc3 = Loc(:,index(3));
% 	v1 = loc2-loc1;
% 	v2 = loc3-loc1;
% 	normal = cross(v1,v2);
% 	a = normal(1);
% 	b = normal(2);
% 	c = normal(3);
% 	d = -a*loc1(1)-b*loc1(2)-c*loc1(3);
% 	cost_sum = 0;
% 	for j = 1:point_num+1
% 		cost_sum += (abs(a*Loc(1,j)+b*Loc(2,j)+c*Loc(3,j)+d))^2/(a^2+b^2+c^2);
% 	end
% 	if cost_sum < cost_sum_min
% 		cost_sum_min = cost_sum;
% 		opt_a = a;
% 		opt_b = b;
% 		opt_c = c;
% 		opt_d = d;
% 	end
% end


