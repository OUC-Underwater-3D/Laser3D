%written by wangnan
%2017.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
load Calib_Results;

Loc_laser = [0 350 0]';
inter = [2122.67054 0 806.40633; 0 2122.11883 596.10524; 0 0 1];
point_num = 8;
p = zeros(3,point_num);
Loc = [];

p(:,1) = [532;602;1];
temp = laser(p(:,1), inter, Rc_16, Tc_16);
Loc = [Loc temp];

p(:,2) = [1080;598;1];
temp = laser(p(:,2), inter, Rc_16, Tc_16);
Loc = [Loc temp];

p(:,3) = [362;692;1];
temp = laser(p(:,3), inter, Rc_17, Tc_17);
Loc = [Loc temp];

p(:,4) = [808;800;1];
temp = laser(p(:,4), inter, Rc_17, Tc_17);
Loc = [Loc temp];

p(:,5) = [208;778;1];
temp = laser(p(:,5), inter, Rc_18, Tc_18);
Loc = [Loc temp];

p(:,6) = [1014;1004;1];
temp = laser(p(:,6), inter, Rc_18, Tc_18);
Loc = [Loc temp];

p(:,7) = [376;696;1];
temp = laser(p(:,7), inter, Rc_24, Tc_24);
Loc = [Loc temp];

p(:,8) = [712;838;1];
temp = laser(p(:,8), inter, Rc_24, Tc_24);
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


