% h = animatedline;
% axis([0,4*pi,-1,1])
% 
% x = linspace(0,4*pi,1000);
% y = sin(x);
% for k = 1:length(x)
%     addpoints(h,x(k),y(k));
%     drawnow
% end

% hold off
% t=0;
% m=0;
% t1=[0 0.1]; %要构成序列
% m1=[sin(t1);cos(t1)];
% p = plot(t,m,'*',t1,m1(1,:),'-r',t1,m1(2,:),'-b','MarkerSize',5);
% x=-1.5*pi;
% axis([x x+2*pi -1.5 1.5]);
% grid on;
% for i=1:100
%     hold on
%     t=0.1*i; %下一个点
%     m=t-floor(t);
%     t1=t1+0.1; %下一段线(组)
%     m1=[sin(t1);cos(t1)];
%     p = plot(t,m,'*',t1,m1(1,:),'-r',t1,m1(2,:),'-b','MarkerSize',5);
%     x=x+0.1;
%     axis([x x+2*pi -1.5 1.5]);
%     pause(0.01);
% end

t=[0];
m=[sin(t);cos(t)];
p = plot(t,m,...
   'EraseMode','background','MarkerSize',5);
x=-1.5*pi;
axis([x x+2*pi -1.5 1.5]);
grid on;
for i=1:1000
    t=[t 0.1*i];                   %Matrix 1*(i+1)
    m=[m [sin(0.1*i);cos(0.1*i)]]; %Matrix 2*(i+1)
    set(p(1),'XData',t,'YData',m(1,:))
    set(p(2),'XData',t,'YData',m(2,:))
    drawnow
    x=x+0.1;
    axis([x x+2*pi -1.5 1.5]);
    pause(0.5);
end

