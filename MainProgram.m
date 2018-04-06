
clear global;
close all;
clc
clearvars;

%This is a list of constants that is dependent on the design (START)
% I am assuming standard metric units (metre, kg, second, N, etc...)


initialXafterSpring = 0.0475; %the actual value from left - Value after the spring release position
SE = initialXafterSpring;
initialX = 0.0445; %assuming compression of 3.5 millimetres
initialY = 0.2435; %The actual value from the bottom in the prototype
springK = 140;  %I don't what is its range or expected value
% springS = 0.035; %the difference between the spring equilibrium and the compression (compression length is S)
mass = 0.0207; %mass of the ball
coeffE = 0.16;
global slopeF;
slopeF = 0.01;
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

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 12, 'MarkerFaceColor', 'r');
hold on;

%Horizontal Part
horizontalResults=slope(0,0.198);
GlobalXYT = [GlobalXYT; horizontalResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

% Rotation Part
[result3] = ori_rotation2(mass,0.0025,0.0125,0.06);
GlobalXYT = [GlobalXYT; result3];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Freefall Part
[result4] = freefall();
GlobalXYT = [GlobalXYT; result4];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

loseEnergy(); %Assuming that the ball loses all its energy at hitting the slope after the free fall

% subplot(1,2,2)
% v = diff(GlobalXYT(1:end,1))./ diff(GlobalXYT(1:end,3));
% vy = diff(GlobalXYT(1:end,2))./ diff(GlobalXYT(1:end,3));
% plot(v,vy)
% title('Vy wrt Vx')

%Slope before curvature Part
slopeResults=slope(156,0.13325);
GlobalXYT = [GlobalXYT; slopeResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Curvature Part
%The following constants are only dependent on the geometry of the design
theta1= -24.36;
theta2 = 70.26;
CurveRadius = 0.048;
[x, y, time] = curve(theta1, theta2, CurveRadius); %function calling
GlobalXYT = [GlobalXYT; [x, y, time]]; %adding the results to the global array

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%projectile part after curvature
projectileResults = projectile();
GlobalXYT = [GlobalXYT; projectileResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Impact Part
%The initial conditions below is just asumption and geometry.
angle_impact_slope = 17; %degrees
%Coefficient of restitution is the last input. I assumed it to be 0.5
[result] = Impact_up_left(angle_impact_slope, GlobalXYT(end,1),GlobalXYT(end,2), GlobalXYT(end,3),coeffE); %Output is in a 3 matrix-columns matrix (x,y,t). Can add into a global array later.
GlobalXYT = [GlobalXYT; result];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Calculate slope length after first bouncing
calculatedLength = sqrt((GlobalXYT(end,1)-0.13482)^2+(GlobalXYT(end,2)-0.08668)^2);

loseEnergy();

%Slope after first bouncing
slopeResults=slope(17,calculatedLength);
GlobalXYT = [GlobalXYT; slopeResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

% %projectile part after curvature
projectileResults = projectile2();
GlobalXYT = [GlobalXYT; projectileResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Impact2
angle_impact_slope = 13;
[result]=Impact_up_right(angle_impact_slope, GlobalXYT(end,1),GlobalXYT(end,2), GlobalXYT(end,3),coeffE);
GlobalXYT = [GlobalXYT; result];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Slope after second impact - upwareds
slopeResults=slopeUpward(13);
GlobalXYT = [GlobalXYT; slopeResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;

%Calculate downwards slope length after upwards slope
calculatedLength2 = sqrt((GlobalXYT(end,1)-0.0195)^2+(GlobalXYT(end,2)-0.0195)^2);

%Slope after second impact - downwards
slopeResults=slope(167,calculatedLength2);
GlobalXYT = [GlobalXYT; slopeResults];

%Draw Separator
plot(GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize', 12, 'MarkerFaceColor', 'r');
hold on;

elapsedTime=GlobalXYT(end,3)

drawWithTime()
%%
%figure;
% subplot(1,2,1)
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
plot(x, y ,'LineWidth', 1, 'color', 'b');
title('Y wrt X')
xlim([0,0.3048])
ylim([0,0.3048])

%%
%elapsedTime=GlobalXYT(end,3)
figure;
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
time = GlobalXYT(:, 3);
vx = diff(GlobalXYT(1:end,1))./ diff(GlobalXYT(1:end,3));
vy = diff(GlobalXYT(1:end,2))./ diff(GlobalXYT(1:end,3));
ax = diff(vx)./ diff(time(1:end-1));
ay = diff(vy)./diff(time(1:end-1));
subplot(1,3,1)
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
plot(x, y);
title('Y vs X')
xlim([0,0.3048])
ylim([0,0.3048])
xlabel('X')
ylabel('Y')

subplot(1,3,2)
v = sqrt(vx.^2+vy.^2);
v = v(~isnan(v) & isfinite(v));
v = v(v<(mean(v)+3*std(v)));
plot(time(1:length(v)), v)
title('V vs Time')
xlabel('Time')
ylabel('Velocity')

subplot(1,3,3)
a = sqrt(ax.^2+ay.^2);
a = a(~isnan(a) & isfinite(a));
a = a(a<(mean(a)+3*std(a)));
plot(time(1:length(a)), a)
xlabel('Time')
ylabel('Acceleration')


title('a vs Time')