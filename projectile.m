function [results]= projectile()
%    This function only works for our specific dimensions
%    because it calculates time based on our design
%    NO INPUT ARGUMENTS NEEDED
%    I calculated time with 3 equations and used algabraic substitutions

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
syms T
eqn= 0.5*g*T^2+( vely+0.2967*velx )*T+( y0-0.11418+0.2967*x0 )==0;
solT=solve(eqn,T);
time=double(solT);                %Convert symbol to double
calulatedTime=time(time>0);       %Take positive time
calulatedTime=min(calulatedTime); %Take the smallest number in the array
t=0:dtime:calulatedTime;

time=GlobalXYT(end,3)+t;
x=x0+velx*t;
y=y0+vely*t-(g*t.^2)/2;

results = [x',y',time'];

end