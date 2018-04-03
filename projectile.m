function [results]= projectile()
%    This function only works for our specific dimensions
%    because it calculates time based on our design
%    NO INPUT ARGUMENTS NEEDED
%    I calculated time with 3 equations and used algabraic substitutions

global GlobalXYT;

dtime = 0.001; %1 millisecond
initial_dtime = GlobalXYT(end,3)-GlobalXYT(end-4,3);
x0=GlobalXYT(end,1);
y0=GlobalXYT(end,2);
dposx=x0-GlobalXYT(end-4,1);
dposy=y0-GlobalXYT(end-4,2);
% y0=y0-0.045;
velx=dposx/initial_dtime;
vely=dposy/initial_dtime;
g=-9.81;

%Solving for time 
%Getting Complex Time with this method
syms X
syms Y
syms T
eq1 = X==x0+velx*T;
eq2 = Y==y0+vely*T+0.5*g*T^2;
% eq3 = -.03282*(X-0.007)==.134839*(Y-.12668);
eq3 = Y==-0.2967*X+0.1265;
% eqn= 0.5*g*T^2+( vely+0.2967*velx )*T+( y0-0.129+0.2967*x0 )==0;
%eqn=-0.297*T-0.297*velx*T+0.129==y0+vely*T+0.5*g*T^2;
[xCalc,yCalc,time]=solve([eq1,eq2,eq3],[X,Y,T]);
time=double(time);                  %Convert symbol to double
calculatedTime=time(time>0);        %Take positive time
calculatedTime=min(calculatedTime); %Take the smallest number in the array

% ESTIMATION based on dimensions and guess of location of impact after
% projectile
% calculatedTime=0.089;

t=0:dtime:calculatedTime;

time=GlobalXYT(end,3)+t;
x=x0+velx*t;
y=y0+vely*t+(g*t.^2)/2;

results = [x',y',time'];

end