function [x1,x2,y1,y2] = hor_bounce(m,r,delta_x,t1,t2,X,Y,v1,a1) 
%m: mass, r: radius
%t1: from spring to before collision
%t2: after collision
%v1: velocity before collsion
%a1: acceleration before collsion
x0 = X;
%g=9.81;
%N = m*g; %normal force
I = 0.4*m*r.^2 + m*(delta_x).^2; %mass moment of inetia
%delta_x: distance from rod joint to ball's centre of mass
w1 = v1/r; %initial angular velocity

syms miu v2 
eqns = [m*(v2-v1) == 0, I*(v2/r-v1/r) == 0];
[miu v2] = solve(eqns, [miu v2]);
w2 = v2/r %angular velocity after collision
a2 = a1;  %angular acceleration after collsion

t01 = 0:0.01:t1;
x1 = x0 + v1*t01 + 0.5*a1*t01.^2;
y1 = Y + t01*0; %to make y1 an array
x1f = x0 + v1*t1 + 0.5*a1*t1.^2; % when the ball hits the wall

t02 = 0:0.01:t2;
x2 = x1f - v2*t02 - 0.5*a2*t02.^2;
y2 = Y + t02*0; %to make y2 an array

end
