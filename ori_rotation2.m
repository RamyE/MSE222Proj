function [result3] = ori_rotation2(mb,mr,rb,l)
global GlobalXYT;
%mb: ball mass
%mr: rod mass
%rb: ball radius
%l: rod length
%d: horizontal bar length
%v1: ball initial velocity
g = 9.81;
e = 0.1; %coefficient of restitution
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
syms anglee
eqanglee = 0.7*mb*((v2^2))+(0.5*Ir*(wr2^2))-mr*y1*g == -mr*y1*g*cos(anglee)+ 0.7*mb*((l-rb)*0)+(0.5*Ir*0);
angle = solve(eqanglee, anglee);
angle = double(angle);
angle = degtorad(24);
% angle = acos(cos_of_angle);

theta = 0:0.001:angle;
omegaF =[];
tF = 0;
x = 0;
y = 0;
for i = 2:length(theta)
    syms OM;
    %0.7*mb*((v2^2))+   -mb*(l-rb)*g                          -mb*(l-rb)*g*cos(theta(i))    0.7*mb*(((l-rb)*(OM)).^2)
    eqn = [0.7*mb*((v2^2))+(0.5*Ir*(wr2^2))- mr*y1*g == (-mr*y1*g*cos(theta(i))+  0.7*mb*((v2^2))  +(0.5*Ir*(OM.^2)))];
    omega = solve(eqn, OM);
    omegad = double(omega);
    omegad = omegad(omegad>0);
    timee = (theta(i)-theta(i-1)) ./ omegad;
    omegaF = [omegaF; omegad];
    x = [x0; x0 + l.*sin(theta(i)-theta(i-1))];
    y = [y0; y0 + 2*l.*(sin((theta(i)-theta(i-1))/2)).^2];
    tF = [tF, tF(end)+timee];
end 

%t = theta ./ omegaF;

figure;
plot(tF(1:end-1), omegaF, 'b');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');

figure;
alphaF = diff(omegaF)./diff(tF(1:length(omega))');
plot(tF(1:length(alphaF)), alphaF, 'r')
xlabel('Time (s)');
ylabel('Angular Acceleration (rad/s^2)');

% ax = (l-rb).*alpha.*cos(theta/2); %ax: horizontal acceleration after impact
% x = x0 + v2.*t + 0.5.*ax.*(t.^2);
% ay = (l-rb).*alpha.*sin(theta/2); %ay: vertical acceleration after impact
% y = y0 + 0.5*(-ay-g).*(t.^2);

time = GlobalXYT(end,3)+ tF;

result3 = [x y time];
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
