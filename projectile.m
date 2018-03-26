function [x,y]= projectile(a,time,X,Y,v)
% This is the old projectile code
%       Good to use for testing projectile motion
%       inputs: a=angle, X=x position, Y=y position, v=magnitude of velocity

x0=X;
y0=Y;
angle=a*(pi./180);
velocity=v;
g=9.81;
dtime = 0.001;
t=0:dtime:time;
x=x0+velocity*cos(angle)*t;
y=y0+velocity*sin(angle)*t-(g*t.^2)/2;

end