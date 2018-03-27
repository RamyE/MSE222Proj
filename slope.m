<<<<<<< refs/remotes/origin/master
function [slopeResults] = slope(a,distance)
% Uses Newtons - Kinematics and Kinetic
%calc v0

global GlobalXYT;

x0=GlobalXYT(end,1);
y0=GlobalXYT(end,2);
g = 9.81;
slopeLength = distance;
angle = a*(pi./180);
coefFriction = 0.7;   %needs to change
dtime=0.001;

acceleration = g*( sin(angle)-coefFriction*cos(angle) );
accelX=acceleration*cos(angle);
accelY=acceleration*sin(angle);
initialVelX=(GlobalXYT(end,1)-GlobalXYT(end-1,1))/(GlobalXYT(end,3)-GlobalXYT(end-1,3));
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-1,2))/(GlobalXYT(end,3)-GlobalXYT(end-1,3));
magnitudeOfVel = sqrt( initialVelX^2 + initialVelY^2 );
initialVelX = magnitudeOfVel*cos(angle);  %change velx so that ball enters in direction of slope
initialVelY = magnitudeOfVel*sin(angle);  %change vely so that ball enters in direction of slope

syms T
eqn = 0.5*g*T^2+initialVelX*T-slopeLength; %from kinematics
solT=double(solve(eqn,T));
time=solT(solT>0);
t=0:dtime:time;

x=x0+initialVelX*t+(1/2)*accelX*t.^2;
y=y0+initialVelY*t+(1/2)*accelY*t.^2;
time=GlobalXYT(end,3)+t;

slopeResults=[x',y',time'];

=======
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



>>>>>>> Renamed Projectile2 to Projectile
end