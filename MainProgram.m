clear global;
close all;
clc
clearvars;

%This is a list of constants that is dependent on the design (START)
% I am assuming standard metric units (metre, kg, second, N, etc...)


initialXafterSpring = 0.0475; %the actual value from left - Value after the spring release position
SE = initialXafterSpring;
initialX = 0.035; %assuming compression of 3.5 millimetres
initialY = 0.2325; %The actual value from the bottom in the prototype
springK = 13.2;  %I don't what is its range or expected value
% springS = 0.035; %the difference between the spring equilibrium and the compression (compression length is S)
mass = 0.05; %mass of the ball


% Constants List (END)

%global X,Y,time array declaration and initialization
global GlobalXYT;
GlobalXYT = [initialX, initialY, 0];

%EXAMPLE of how to caoncatenate to the global array a function results 
%         tempX = [3,6,7,0.3,0.5];
%         tempY = [45, 45,  67, 0.3, 0.5];
%         tempT = [0.001,0.002,0.003,0.1,2];
%         tempXYT = [tempX',tempY',tempT'];
%         GlobalXYT = [GlobalXYT; tempXYT];

%Spring Part
[x, y, time] = springDetail(initialX, SE, springK, mass); %function calling
GlobalXYT = [GlobalXYT; [x, y, time]]; %adding the results to the global array

%Horizontal Part
horizontalResults=slope(0,0.207);
GlobalXYT = [GlobalXYT; horizontalResults];

% %Curvature Part
% %The following constants are only dependent on the geometry of the design
% theta1= -45;
% theta2 = 80;
% CurveRadius = 0.025;
% [x, y, time] = curve(theta1, theta2, CurveRadius); %function calling
% GlobalXYT = [GlobalXYT; [x, y, time]]; %adding the results to the global array

%Projectile Part
projectileResults = projectile();
GlobalXYT = [GlobalXYT; projectileResults];

%Impact Part
%The initial conditions below is just asumption and geometry.
angle_impact_slope = 25; %degrees
%Coefficient of restitution is the last input. I assumed it to be 0.5
[result] = Impact_up_left(angle_impact_slope, GlobalXYT(end,1),GlobalXYT(end,2), GlobalXYT(end,3),0.2); %Output is in a 3 matrix-columns matrix (x,y,t). Can add into a global array later.
GlobalXYT = [GlobalXYT; result];
%Up slope impact. Debug only.
[result2] = Impact_up_right(12, GlobalXYT(end,1),GlobalXYT(end,2), GlobalXYT(end,3),0.2);
GlobalXYT = [GlobalXYT; result2];
figure;
plot(GlobalXYT(:,1), GlobalXYT(:,2), 'c')
xlabel('X')
ylabel('Y')
xlim([-0.1, 12])
ylim([0, 12])
title('Y versus X of Impact-up Bounce Projectile')
grid on
grid minor
pbaspect([1 1 1])
hold on