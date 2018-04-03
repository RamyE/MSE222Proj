clear global;
close all;
clc
clearvars;

%This is a list of constants that is dependent on the design (START)
% I am assuming standard metric units (metre, kg, second, N, etc...)


initialXafterSpring = 0.0475; %the actual value from left - Value after the spring release position
SE = initialXafterSpring;
initialX = 0.0425; %assuming compression of 3.5 millimetres
initialY = 0.2443; %The actual value from the bottom in the prototype
springK = 50;  %I don't what is its range or expected value
% springS = 0.035; %the difference between the spring equilibrium and the compression (compression length is S)
mass = 0.0207; %mass of the ball


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
horizontalResults=slope(0,0.198);
GlobalXYT = [GlobalXYT; horizontalResults];

% Rotation Part
[result3] = ori_rotation(mass,0.005,0.0125,0.06);
GlobalXYT = [GlobalXYT; result3];

%Freefall Part
[result4] = freefall();
GlobalXYT = [GlobalXYT; result4];

loseEnergy(); %Assuming that the ball loses all its energy at hitting the slope after the free fall

% subplot(1,2,2)
% v = diff(GlobalXYT(1:end,1))./ diff(GlobalXYT(1:end,3));
% vy = diff(GlobalXYT(1:end,2))./ diff(GlobalXYT(1:end,3));
% plot(v,vy)
% title('Vy wrt Vx')

%Slope before curvature Part
slopeResults=slope(156,0.13325);
GlobalXYT = [GlobalXYT; slopeResults];

%Curvature Part
%The following constants are only dependent on the geometry of the design
theta1= -24.36;
theta2 = 70.26;
CurveRadius = 0.048;
[x, y, time] = curve(theta1, theta2, CurveRadius); %function calling
GlobalXYT = [GlobalXYT; [x, y, time]]; %adding the results to the global array

%projectile part after curvature
projectileResults = projectile()
GlobalXYT = [GlobalXYT; projectileResults];

%Impact Part
%The initial conditions below is just asumption and geometry.
angle_impact_slope = 25; %degrees
%Coefficient of restitution is the last input. I assumed it to be 0.5
[result] = Impact_up_left(angle_impact_slope, GlobalXYT(end,1),GlobalXYT(end,2), GlobalXYT(end,3),0.2); %Output is in a 3 matrix-columns matrix (x,y,t). Can add into a global array later.
GlobalXYT = [GlobalXYT; result];

elapsedTime=GlobalXYT(end,3)
figure;
% subplot(1,2,1)
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
plot(x, y);
title('Y wrt X')
xlim([0,0.3048])
ylim([0,0.3048])
%%
elapsedTime=GlobalXYT(end,3)
figure;
subplot(1,2,1)
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
plot(x, y);
title('Y wrt X')
xlim([0,0.3048])
ylim([0,0.3048])
subplot(1,2,2)
v = diff(GlobalXYT(1:end,1))./ diff(GlobalXYT(1:end,3));
vy = diff(GlobalXYT(1:end,2))./ diff(GlobalXYT(1:end,3));
plot(v,vy)
title('Vy wrt Vx')



%Up slope impact. Debug only.
[result2] = Impact_up_right(12, GlobalXYT(end,1),GlobalXYT(end,2), GlobalXYT(end,3),0.2);
GlobalXYT = [GlobalXYT; result2];
