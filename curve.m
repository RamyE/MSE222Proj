 function [x,y,time] = curve(theta1, theta2, radius)
  %theta1 is supposed to be negative
  %theta2 is supposed to be a positive value and the last angle which is
  %the angle of the projectile
  %radius is for the curvature and not the ball
  %units is kg, m, rad, etc...
 dtheta = 0.001; %decrease for more accuracy
 
 %OVERRIDING function paramaters only for TESTING
%  theta1=-45;
%  theta2=70;
%  radius=0.1;
 % ============================
 
 global GlobalXYT; %letting the function know about the global array
 Vx = (GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
 Vy = (GlobalXYT(end,2) - GlobalXYT(end-1,2))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
 Vinitial = sqrt(Vx.^2 + Vy.^2); %calculating the initial velocity from the last element data
 
 theta1 = degtorad(theta1);
 theta2 = degtorad(theta2);
 theta = theta1:dtheta:theta2;
 

 chord = 2*radius*sin(dtheta/2); %length of the chord of the circle corresponding to dtheta
 time = 0 + GlobalXYT(end,3); %initialzing the the time with the last value of time from the last element
 x = GlobalXYT(end,1) + chord*-cos(theta1); %initialzing the x in the global coordinates
 y = GlobalXYT(end,2) + chord*sin(theta1); %initialzing the y in the global coordinates
 
 for i = theta(1:end-1)
  V2 = sqrt( (Vinitial.^2) +(10/7)*9.81*radius*(cos(i+dtheta)-cos(i)));
  dx = chord*-cos(i+dtheta); %x distance moved through the dtheta 
  dy = chord*sin(i+dtheta); %y distance moved through the dtheta
  [x] = [x; x(end)+dx]; %adding the increased dx 
  [y] = [y; y(end)+dy]; %adding the increased dy 
  [time] = [time; time(end)+((dtheta*radius)/V2)]; %calcualting time and add it to the previoud time consumed 
  %[time] = [time; ((dtheta*radius)/V2)];
  Vinitial = V2; 
 end
 
 %GlobalXYT = [GlobalXYT; [x,y,time]];
 
 %ALL THE PLOTS BELOW ARE FOR TESTING ONLY
 
 %plot(time)
%  plot(x,y)
% xlim([-0.2 0.2]);
% ylim([-0.2 0.2]);
%  xlabel(x);
%  ylabel(y);
%  plot3(x,y,time);