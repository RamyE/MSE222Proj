%Free fall from the rod
function [result4] = freefall();
global GlobalXYT;
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);
delta_x = GlobalXYT(end,1) - (0.251+0.037-0.164*cos(24/180*pi));
h = GlobalXYT(end,2) - 0.128184 - delta_x*tan(24/180*pi);
g = 9.81;
fall_time = sqrt(2*h/g);
t2 = 0:0.01:fall_time;
x = x0 + 0*t2;
y = y0 - 0.5*g*t2.^2;
t2=t2+GlobalXYT(end,3);
result4 = [x' y' t2'];
end