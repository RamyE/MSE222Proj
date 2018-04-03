%Free fall from the rod
global GlobalXYT;

delta_x = GlobalXYT(end,1) - (0.251+0.037-0.164*cos(24/180*pi))
h = GlobalXYT(end,2) - 0.128184 - delta_x*tan(24/180*pi)
fall_time = sqrt(2*h/g)
t2 = 0:0.01:fall_time;
x = x + 0*t2;
y = y - 0.5*g*t2.^2;