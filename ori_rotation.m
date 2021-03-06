function [result3] = ori_rotation(mb,mr,rb,l)
global GlobalXYT;
%mb: ball mass
%mr: rod mass
%rb: ball radius
%l: rod length
%d: horizontal bar length
%v1: ball initial velocity
g = 9.81;
e = 0.01; %coefficient of restitution
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);
% x0 = 0.251;
% y0 = 0.2218;
%Conservation of Momentum
v1 = (GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));

syms V2 VR2
%v2: ball velocity after impact with rod
%vr2: rod velocity after impact with ball
I = (1/3)*mr*l^2 + 0.4*mb*rb^2 + mb*(l-rb)^2;
eqns = [(l-rb)*mb*(V2-v1)+ I*VR2/l == 0, VR2-V2-e*v1 == 0];
[v2,vr2] = solve(eqns, [V2 VR2]);
v2=double(v2);
vr2=double(vr2);
wr2 = vr2/l; %wr2: rod angular velocity after impact

%Conservation of Energy
y1 = (mr*(l/2) + mb*(l-rb))/(mr + mb);
% y2 = y1 * cos(angle);
%(mb+mr)*g*y1*(1-cos(angle)) == 0.5*(mb*v2^2+I*wr2^2);
cos_of_angle = (1-(0.5*(mb*v2^2+I*wr2^2))/((mb+mr)*g*y1));
angle = acos(1-(0.5*(mb*v2^2+I*wr2^2))/((mb+mr)*g*y1));

theta = 0:0.01:angle;
t = theta./wr2;
alpha = wr2./t;
% ax = (l-rb).*alpha.*cos(theta/2); %ax: horizontal acceleration after impact
% x = x0 + v2.*t + 0.5.*ax.*(t.^2);
% ay = (l-rb).*alpha.*sin(theta/2); %ay: vertical acceleration after impact
% y = y0 + 0.5*(-ay-g).*(t.^2);
x = x0 + l.*sin(theta);
y = y0 + 2*l.*(sin(theta/2)).^2;
time = GlobalXYT(end,3)+ t;

result3 = [x' y' time'];
end