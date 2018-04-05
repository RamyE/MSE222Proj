function [result3] = ori_rotation2(mb,mr,rb,l)
global GlobalXYT;
%mb: ball mass
%mr: rod mass
%rb: ball radius
%l: rod length
%d: horizontal bar length
%v1: ball initial velocity
g = 9.81;
e = 0.10; %coefficient of restitution
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);
% x0 = 0.251;
% y0 = 0.2218;
%Conservation of Momentum
v1 = (GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
syms V2 VR2
%v2: ball velocity after impact with rod
%vr2: rod velocity after impact with ball
I = (1/3)*mr*(l^2) + 0.4*mb*(rb^2) + mb*((l-rb)^2);
Ir = (1/3)*mr*(l^2);
eqns = [(l-rb)*mb*(V2-v1)+ I*VR2/(l-rb) == 0, VR2-V2-e*v1 == 0];
[v2,vr2] = solve(eqns, [V2 VR2]);
v2=double(v2);
vr2=double(vr2);
wr2 = vr2/(l-rb); %wr2: rod angular velocity after impact

%Conservation of Energy
y1 = (mr*(l/2) + 0*(l-rb))/(mr + 0);
% y2 = y1 * cos(angle);
%(mb+mr)*g*y1*(1-cos(angle)) == 0.5*(mb*v2^2+I*wr2^2);
cos_of_angle = (1-(0.5*(mb*(v2^2)+I*(wr2^2)))/((0+mr)*g*y1));
angle = acos(cos_of_angle);

theta = 0:0.01:angle;
omegaF =[];
tF = 0;
for i = 2:length(theta)
    syms OM;
    eqn = [0.5*mb*((v2^2))+(0.5*Ir*(wr2^2))-mr*y1*g == (-mr*y1*g*cos(theta(i))+ 0.5*mb*((l-rb)*(OM.^2))+(0.5*Ir*(OM.^2)))];
    omega = solve(eqn, OM);
    omegad = double(omega);
    omegad = omegad(omegad>0);
    timee = (theta(i)-theta(i-1)) / omegad;
    omegaF = [omegaF; omegad];
    tF = [tF, tF(end)+timee];
end


t = theta ./ omegaF;
% wr2 = 0 -;
% alpha = wr2./t;

% ax = (l-rb).*alpha.*cos(theta/2); %ax: horizontal acceleration after impact
% x = x0 + v2.*t + 0.5.*ax.*(t.^2);
% ay = (l-rb).*alpha.*sin(theta/2); %ay: vertical acceleration after impact
% y = y0 + 0.5*(-ay-g).*(t.^2);

% x = x0 + l.*sin(theta);
% y = y0 + 2*l.*(sin(theta/2)).^2;
% time = GlobalXYT(end,3)+ t;
% 
result3 = [x' y' time'];
% 
% hold on
% figure;
% subplot(2,1,1)
% plot(x,y,'r')
% xlabel('X');
% ylabel('Y');
% title('Ball position in Rotation');
% 
% subplot(2,1,2)
% plot(t,wr2,'r')
% xlabel('X');
% ylabel('Y');
% title('Angular Velocity in Rotation');

end