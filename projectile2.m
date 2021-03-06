function [results]= projectile2()
%    This function only works for our specific dimensions
%    because it calculates time based on our design
%    NO INPUT ARGUMENTS NEEDED
%    I calculated time with 3 equations and used algabraic substitutions
%    This projectile function is for the positive slope element

global GlobalXYT;

dtime = 0.001; %1 millisecond
initial_dtime = GlobalXYT(end,3)-GlobalXYT(end-1,3);
x0=GlobalXYT(end,1);
y0=GlobalXYT(end,2);
dposx=x0-GlobalXYT(end-4,1);
dposy=y0-GlobalXYT(end-4,2);
velx=dposx/initial_dtime;
vely=dposy/initial_dtime;
g=9.81;

%Solving for time 
%Getting Complex Time with this method
syms X
syms Y
syms T
eq1 = X==x0+velx*T;
eq2 = Y==y0+vely*T+0.5*g*T^2;
% eq3 = -.03282*(X-0.007)==.134839*(Y-.12668);
eq3 = Y==(74.8/290)*X+.0195;
[xCalc,yCalc,time]=solve([eq1,eq2,eq3],[X,Y,T]);
time=double(time);                  %Convert symbol to double
calculatedTime=time(time>0);        %Take positive time
calculatedTime=min(calculatedTime); %Take the smallest number in the array

t=0:dtime:calculatedTime;

time=GlobalXYT(end,3)+t;
x=x0+velx*t;
y=y0+vely*t-(g*t.^2)/2;

results = [x',y',time'];

end