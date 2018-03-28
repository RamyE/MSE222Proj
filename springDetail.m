 function [x,y,time] = springDetail(S1, Se, K, m)
  %S1 is the starting X position of the compressed spring
  %Se is the equilbrium position of the spring and the position when the
  %ball will be set free
  %K is the constant of the spring
  %m is the mass of the ball
  %units is kg, m, rad, etc...
 ds = 0.0001; %decrease for more accuracy
 
 %OVERRIDING function paramaters only for TESTING
%  S1=0.02;
%  Se=0.05;
%  m = 0.02;
%  K = 0.05;
 % ============================
 
 global GlobalXYT; %letting the function know about the global array
 Vinitial = 0; %the ball starts from rest
 
 s = S1:ds:Se;
 
 time = 0 + GlobalXYT(end,3); %initialzing the the time with the last value of time from the last element
 x = GlobalXYT(end,1); %initialzing the x in the global coordinates
 % x = 0; time = 0;
 for i = s(1:end-1)
  V2 = sqrt( (Vinitial.^2) + ((5*K)/(7*m))* ( (Se-i).^2 - (Se-i-ds).^2 ) );
  [x] = [x; x(end)+ds]; %adding the increased dx 
  [time] = [time; time(end)+((ds)/V2)]; %calcualting time and add it to the previous time consumed 
  %[time] = [time; (ds/V2)];
  Vinitial = V2; 
 end
  
 y= ones(length(x), 1)* GlobalXYT(end,2);
 %GlobalXYT = [GlobalXYT; [x,y,time]];
 %ALL THE PLOTS BELOW ARE FOR TESTING ONLY

 %plot(time)
% plot(time,x)
% xlim([-0.2 0.2]);
% ylim([-0.2 0.2]);
%  xlabel(x);
%  ylabel(y);
%  plot3(x,y,time);