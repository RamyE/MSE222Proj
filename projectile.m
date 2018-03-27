function [results]= projectile()
% How to use this Function:
%       This function takes in global time,X,Y 
%       Need a descently generated X,Y path before using this function
%       Also, this is extremepy dependent on the correct dimensioning of
%       the entire system!!!
%       The results are the updated X,Y & time


global GlobalXYT;

dtime = 0.001; %1 millisecond
initial_dtime = GlobalXYT(end,3)-GlobalXYT(end-1,3);
x0=GlobalXYT(end,1);
y0=GlobalXYT(end,2);
dposx=x0-GlobalXYT(end-1,1);
dposy=y0-GlobalXYT(end-1,2);
velx=dposx/initial_dtime;
vely=dposy/initial_dtime;
g=9.81;

%Solving for time
syms T
eqn= 0.5*g*T^2+( vely+0.5*velx )*T+( y0-0.39+0.5*x0 )==0;
solT=solve(eqn,T);
time=double(solT);
calulatedTime=time(time>0);
t=0:dtime:calulatedTime;

time=GlobalXYT(end,3)+t;
x=x0+velx*t;
y=y0+vely*t-(g*t.^2)/2;

results = [x',y',time'];

end