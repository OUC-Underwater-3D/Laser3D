%written by wangnan
%2017.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
load Calib_Results;

Loc_laser = [0 350 0]';
inter = [2047.12346 0 1238.38779; 0 2052.37256 904.14504; 0 0 1];
point_num = 40;
p = zeros(3,point_num);
Loc = [];

p(:,1) = [260;1442;1];
temp = pinv(inter*[Rc_1 Tc_1])*p(:,1);
temp = [Rc_1 Tc_1]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,2) = [1819;1428;1];
temp = pinv(inter*[Rc_1 Tc_1])*p(:,2);
temp = [Rc_1 Tc_1]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,3) = [415;1555;1];
temp = pinv(inter*[Rc_2 Tc_2])*p(:,3);
temp = [Rc_2 Tc_2]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,4) = [1862;1328;1];
temp = pinv(inter*[Rc_2 Tc_2])*p(:,4);
temp = [Rc_2 Tc_2]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,5) = [376;1442;1];
temp = pinv(inter*[Rc_3 Tc_3])*p(:,5);
temp = [Rc_3 Tc_3]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,6) = [2030;1628;1];
temp = pinv(inter*[Rc_3 Tc_3])*p(:,6);
temp = [Rc_3 Tc_3]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,7) = [579;1680;1];
temp = pinv(inter*[Rc_4 Tc_4])*p(:,7);
temp = [Rc_4 Tc_4]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,8) = [1750;1385;1];
temp = pinv(inter*[Rc_4 Tc_4])*p(:,8);
temp = [Rc_4 Tc_4]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,9) = [783;1412;1];
temp = pinv(inter*[Rc_5 Tc_5])*p(:,9);
temp = [Rc_5 Tc_5]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,10) = [1743;1298;1];
temp = pinv(inter*[Rc_5 Tc_5])*p(:,10);
temp = [Rc_5 Tc_5]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,11) = [686;1603;1];
temp = pinv(inter*[Rc_6 Tc_6])*p(:,11);
temp = [Rc_6 Tc_6]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,12) = [1530;1305;1];
temp = pinv(inter*[Rc_6 Tc_6])*p(:,12);
temp = [Rc_6 Tc_6]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,13) = [211;1640;1];
temp = pinv(inter*[Rc_7 Tc_7])*p(:,13);
temp = [Rc_7 Tc_7]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,14) = [1530;1044;1];
temp = pinv(inter*[Rc_7 Tc_7])*p(:,14);
temp = [Rc_7 Tc_7]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,15) = [754;1155;1];
temp = pinv(inter*[Rc_8 Tc_8])*p(:,15);
temp = [Rc_8 Tc_8]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,16) = [1702;1323;1];
temp = pinv(inter*[Rc_8 Tc_8])*p(:,16);
temp = [Rc_8 Tc_8]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,17) = [752;1187;1];
temp = pinv(inter*[Rc_9 Tc_9])*p(:,17);
temp = [Rc_9 Tc_9]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,18) = [1468;984;1];
temp = pinv(inter*[Rc_9 Tc_9])*p(:,18);
temp = [Rc_9 Tc_9]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,19) = [881;1162;1];
temp = pinv(inter*[Rc_10 Tc_10])*p(:,19);
temp = [Rc_10 Tc_10]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,20) = [1582;1360;1];
temp = pinv(inter*[Rc_10 Tc_10])*p(:,20);
temp = [Rc_10 Tc_10]*temp.*(1/temp(4));
Loc = [Loc temp];


p(:,21) = [754;1185;1];
temp = pinv(inter*[Rc_11 Tc_11])*p(:,21);
temp = [Rc_11 Tc_11]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,22) = [1536;1121;1];
temp = pinv(inter*[Rc_11 Tc_11])*p(:,22);
temp = [Rc_11 Tc_11]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,23) = [790;1119;1];
temp = pinv(inter*[Rc_12 Tc_12])*p(:,23);
temp = [Rc_12 Tc_12]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,24) = [1646;1075;1];
temp = pinv(inter*[Rc_12 Tc_12])*p(:,24);
temp = [Rc_12 Tc_12]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,25) = [681;1294;1];
temp = pinv(inter*[Rc_13 Tc_13])*p(:,25);
temp = [Rc_13 Tc_13]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,26) = [1418;1460;1];
temp = pinv(inter*[Rc_13 Tc_13])*p(:,26);
temp = [Rc_13 Tc_13]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,27) = [583;1389;1];
temp = pinv(inter*[Rc_14 Tc_14])*p(:,27);
temp = [Rc_14 Tc_14]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,28) = [1375;1255;1];
temp = pinv(inter*[Rc_14 Tc_14])*p(:,28);
temp = [Rc_14 Tc_14]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,29) = [1154;1348;1];
temp = pinv(inter*[Rc_15 Tc_15])*p(:,29);
temp = [Rc_15 Tc_15]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,30) = [1655;1396;1];
temp = pinv(inter*[Rc_15 Tc_15])*p(:,30);
temp = [Rc_15 Tc_15]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,31) = [658;1405;1];
temp = pinv(inter*[Rc_16 Tc_16])*p(:,31);
temp = [Rc_16 Tc_16]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,32) = [1161;1130;1];
temp = pinv(inter*[Rc_16 Tc_16])*p(:,32);
temp = [Rc_16 Tc_16]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,33) = [631;1314;1];
temp = pinv(inter*[Rc_17 Tc_17])*p(:,33);
temp = [Rc_17 Tc_17]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,34) = [1370;1187;1];
temp = pinv(inter*[Rc_17 Tc_17])*p(:,34);
temp = [Rc_17 Tc_17]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,35) = [636;1433;1];
temp = pinv(inter*[Rc_18 Tc_18])*p(:,35);
temp = [Rc_18 Tc_18]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,36) = [1452;1408;1];
temp = pinv(inter*[Rc_18 Tc_18])*p(:,36);
temp = [Rc_18 Tc_18]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,37) = [444;1458;1];
temp = pinv(inter*[Rc_19 Tc_19])*p(:,37);
temp = [Rc_19 Tc_19]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,38) = [1095;1066;1];
temp = pinv(inter*[Rc_19 Tc_19])*p(:,38);
temp = [Rc_19 Tc_19]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,39) = [490;1435;1];
temp = pinv(inter*[Rc_20 Tc_20])*p(:,39);
temp = [Rc_20 Tc_20]*temp.*(1/temp(4));
Loc = [Loc temp];

p(:,40) = [1211;1426;1];
temp = pinv(inter*[Rc_20 Tc_20])*p(:,40);
temp = [Rc_20 Tc_20]*temp.*(1/temp(4));
Loc = [Loc temp];

X = [Loc_laser(1) Loc(1,:)];
Y = [Loc_laser(2) Loc(2,:)];
Z = [Loc_laser(3) Loc(3,:)];

xyz = [ones(point_num+1,1) X' Y'];
para = regress(Z', xyz)
xfit = min(X):0.1:max(X);  
yfit = min(Y):0.1:max(Y);
[XFIT,YFIT]= meshgrid (xfit,yfit); 
ZFIT = para(1) + para(2) * XFIT + para(3) * YFIT;

figure, plot3(X,Y,Z,'o');
hold on;
mesh(XFIT,YFIT,ZFIT);
hold on;
plot3(0,0,0,'.r','markersize',16)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on;






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


