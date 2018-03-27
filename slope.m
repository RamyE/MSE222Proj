function [x,y] = slope(a,s,time,initial_angVel)
% Will use Kinetic Energy and Work
%   s=total distance to roll

global GlobalXYT;

angularVelocity = initial_angVel;
lengthOfRoll = s;
dtime=0.001;
t=0:dtime:time;
x0=GlobalXYT(end,1);
y0=GlobalXYT(end,2);
g = 9.81;
radiusBall=0.05;
angle=a*(pi./180);
omega = sqrt( angularVelocity^2 +(g/radiusBall^2)*lengthOfRoll*sin(angle) );



end