
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
load Calib_Results;

% Loc_laser = [0 350 0]';
inter = [2757.85389 0 1252.18673; 0 2764.69304 962.78821; 0 0 1];
[p_temp,img_num]=aget_image_point;
point_num =img_num*2;
p = zeros(3,point_num);
Loc = [];
%%%%%%%%%%%%
j=1;
for i=1:point_num
p(:,i) = [p_temp(i,1);p_temp(i,2);1];
    Rc=eval(['Rc_',num2str(j)]);
    Tc=eval(['Tc_',num2str(j)]);
        if  mod(i,2)==0
        j=j+1;
    end
temp = laser(p(:,i), inter, Rc, Tc);
Loc = [Loc temp];
end
% X = [Loc_laser(1) Loc(1,:)];
% Y = [Loc_laser(2) Loc(2,:)];
% Z = [Loc_laser(3) Loc(3,:)];
% xyz = [ones(point_num+1,1) X' Y'];
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
% plot3(0,0,0,'.r','markersize',16)
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


