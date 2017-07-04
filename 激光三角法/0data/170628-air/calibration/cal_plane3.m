%written by wangnan
%2017.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
load Calib_Results;

Loc_laser = [0 350 0]';
inter = [702.59358 0 303.06242; 0 703.49340 227.21638; 0 0 1];
point_num = 8;
p = zeros(3,point_num);
Loc = [];

p(:,1) = [118;279;1];
temp = laser(p(:,1), inter, Rc_1, Tc_1);
Loc = [Loc temp];

p(:,2) = [107;225;1];
temp = laser(p(:,2), inter, Rc_2, Tc_2);
Loc = [Loc temp];

p(:,3) = [523;143;1];
temp = laser(p(:,3), inter, Rc_3, Tc_3);
Loc = [Loc temp];

p(:,4) = [444;255;1];
temp = laser(p(:,4), inter, Rc_4, Tc_4);
Loc = [Loc temp];

p(:,5) = [109;272;1];
temp = laser(p(:,5), inter, Rc_5, Tc_5);
Loc = [Loc temp];

p(:,6) = [351;213;1];
temp = laser(p(:,6), inter, Rc_6, Tc_6);
Loc = [Loc temp];

p(:,7) = [351;226;1];
temp = laser(p(:,7), inter, Rc_7, Tc_7);
Loc = [Loc temp];

p(:,8) = [428;222;1];
temp = laser(p(:,8), inter, Rc_8, Tc_8);
Loc = [Loc temp];


% X = [Loc_laser(1) Loc(1,:)];
% Y = [Loc_laser(2) Loc(2,:)];
% Z = [Loc_laser(3) Loc(3,:)];
% xyz = [ones(point_num+1,1) X' Y'];
X = Loc(1,:);
Y = Loc(2,:);
Z = Loc(3,:);

xyz = [ones(point_num,1) X' Y'];
para = regress(Z', xyz)
xfit = min(X):0.02:max(X);  
yfit = min(Y):0.02:max(Y);

[XFIT,YFIT]= meshgrid(xfit,yfit); 
ZFIT = para(1) + para(2) * XFIT + para(3) * YFIT;

figure, plot3(X,Y,Z,'o');
hold on;
axis equal;
mesh(XFIT,YFIT,ZFIT);
plot3(0,0,0,'.r','markersize',16)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on;
hold off;





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


