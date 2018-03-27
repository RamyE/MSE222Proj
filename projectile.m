function [results]= projectile(time)
% How to use this Function:
%       This function takes in global time,X,Y 
%       Use this function if there is a generated X,Y path already
%       The results are the updated X,Y global coordinates and the
%       time added to the global time

global GlobalXYT;

dtime = 0.001; %1 millisecond
dposx=GlobalXYT(end,1)-GlobalXYT(end-1,1);
dposy=GlobalXYT(end,2)-GlobalXYT(end-1,2);
velx=dposx/dtime;
vely=dposy/dtime;
g=9.81;
t=0:dtime:time;
time=GlobalXYT(end,3)+t;
x=GlobalXYT(end,1)+velx*t;
y=GlobalXYT(end,2)+vely*t-(g*t.^2)/2;

results = [x',y',time'];

end