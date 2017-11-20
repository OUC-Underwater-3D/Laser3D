function temp = Uw3D_Laser(p, inter, Rc,Tc)

temp_n(1) = (p(1)-inter(1,3))/inter(1,1);
temp_n(2) = (p(2)-inter(2,3))/inter(2,2);

t = pinv(Rc);

a=t(3,1);
b=t(3,2);
c=t(3,3);
d = Tc(1)*a+ Tc(2)*b+ Tc(3)*c; 
t_z = d/(a*temp_n(1)+b*temp_n(2)+c);
t_x=t_z*temp_n(1);
t_y=t_z*temp_n(2);
temp = [t_x; t_y; t_z];