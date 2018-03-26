function [x,y] = slope(a,s,time,X,Y,initial_angVel)
% Will use Kinetic Energy and Work
%   s=total distance to roll

angularVelocity = initial_angVel;
lengthOfRoll = s;
dtime=0.001;
t=0:dtime:time;
x0=X(end);
y0=Y(end);
g = 9.81;
radiusBall=0.05;
angle=a*(pi./180);
omega = sqrt( angularVelocity^2 +(g/radiusBall^2)*lengthOfRoll*sin(angle) );
vx=omega*radiusBall*cos(angle);
vy=omega*radiusBall*sin(angle);
x=omega*radiusBall*cos(angle)*t;
y=omega*radiusBall*sin(angle)*t;

end