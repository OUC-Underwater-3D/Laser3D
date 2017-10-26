function temp = laser(p, inter, Rc_1, Tc_1)

% inter = [2047.12346 0 1238.38779; 0 2052.37256 904.14504; 0 0 1];

% p(:,1) = [260;1442;1];
temp_n(1) = (p(1)-inter(1,3))/inter(1,1);
temp_n(2) = (p(2)-inter(2,3))/inter(2,2);

t = pinv(Rc_1);
a = t(3,1);
b = t(3,2);
c = t(3,3);
d = Tc_1(1)*a+ Tc_1(2)*b+ Tc_1(3)*c; 

t_z = d/(a*temp_n(1)+b*temp_n(2)+c);
t_x=t_z*temp_n(1);
t_y=t_z*temp_n(2);
temp = [t_x; t_y; t_z];
