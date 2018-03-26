 function [x,y,t] = curve(theta1, theta2, radius)
 theta1=-30;
 theta2=90;
 radius=0.1;
 dtheta = 0.0005;
 %theta1 is supposed to be negative
 global GlobalXYT;
 Vx = (GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
 Vy = (GlobalXYT(end,2) - GlobalXYT(end-1,2))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
 Vinitial = sqrt(Vx.^2 + Vy.^2);
 theta1 = degtorad(theta1);
 theta2 = degtorad(theta2);
 theta = theta1:dtheta:theta2;
 

 time = 0;
  chord = 2*radius*sin(dtheta/2);

 x = chord*cos(theta1);
 y = chord*sin(theta1);
 for i = theta(1:end-1)
  V2 = sqrt( (Vinitial.^2) +(10/7)*9.81*radius*(cos(i+dtheta)-cos(i)) );
  Xf = chord*cos(i+dtheta);
  Yf = chord*sin(i+dtheta);
  [x] = [x; x(end)+Xf];
  [y] = [y; y(end)+Yf];
  [time] = [time; time(end)+((dtheta*radius)/V2)];
  Vinitial = V2;
 end
 
 plot(time)
 plot(x,y)
 xlim([-0.2 0.2]);
 ylim([-0.2 0.2]);
%  xlabel(x);
%  ylabel(y);
%  plot3(x,y,time);