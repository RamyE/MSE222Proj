function [slopeResults] = slopeUpward(a)
% Uses Newtons - Kinematics and Kinetic
%   Input Arguments are slope(ANGLE,LENGTH OF SLOPE)


global GlobalXYT;
global slopeF;
x0=GlobalXYT(end,1);
y0=GlobalXYT(end,2);
g = 9.81;
%slopeLength = distance;
angle = -a*(pi./180);
coefFriction = slopeF;   %Change this to match physical model
dtime=0.001;

acceleration = g*( sin(angle)-coefFriction*cos(angle) );
initialVelX=(GlobalXYT(end,1)-GlobalXYT(end-4,1))/(GlobalXYT(end,3)-GlobalXYT(end-4,3));
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-4,2))/(GlobalXYT(end,3)-GlobalXYT(end-4,3));
magnitudeOfVel = sqrt( initialVelX^2 + initialVelY^2 );

syms T
eqn = 0 == magnitudeOfVel + acceleration*T;
solT=double(solve(eqn,T));
calculatedTime=solT(solT>0);
calculatedTime=min(calculatedTime);
t=0:dtime:calculatedTime;

% syms T
% eqn = 0.5*acceleration*T^2+magnitudeOfVel*T-slopeLength==0; %from kinematics
% solT=double(solve(eqn,T));
% calculatedTime=solT(solT>0);
% calculatedTime=min(calculatedTime);
% t=0:dtime:calculatedTime;

d= magnitudeOfVel*t+(1/2)*acceleration*t.^2;
%x=x0+initialVelX*t+(1/2)*accelX*t.^2;
%y=y0+initialVelY*t+(1/2)*accelY*t.^2;
x = x0 + d*cos(angle);
y = y0 - d*sin(angle);
time=GlobalXYT(end,3)+t;

slopeResults=[x',y',time'];

plot(x,y);

end