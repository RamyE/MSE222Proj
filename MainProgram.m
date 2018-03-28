clc
clear all;
close all;
clearvars;

%This is a list of constants that is dependent on the design (START)
% I am assuming standard metric units (metre, kg, second, N, etc...)


initialX = 0.05; %Assuming around 5 cm from left - Value after the spring release position
initialY = 0.27; %Assuming around 3 cm from top
springK = 5;  %I don't what is its range or expected value
springS1 = 0.02;
springS2 = 0.035; %Assumed values given that S2 has to be larger than S1 (After spring is released)
%S2 is also considered the spring equilibrium position
mass = 0.05; %mass of the ball


% Constants List (END)

%global X,Y,time array declaration and initialization
global GlobalXYT;
GlobalXYT = [initialX, initialY, 0];

%EXAMPLE of how to caoncatenate to the global array a function results 
tempX = [3,6,7,8,9];
tempY = [45, 45,  67, 78, 66];
tempT = [0.001,0.002,0.003,0.004,0.005];
tempXYT = [tempX',tempY',tempT'];
GlobalXYT = [GlobalXYT; tempXYT];

%determine the initial velocity after the spring
%initialV = spring (springK, springS1, springS2, mass);
%the initial velocity in the X direction.
%We will start our initial X after the spring distance




%Impact Part
%The initial conditions below is just asumption.
% angle_impact_slope = 30; %degrees
% global_time = 5; %When the impact start
% bouncing_time = 3; %seconds
% X_after_proj = 50;
% Y_after_proj = 80;
% Contact_velocity = 10; %m/s
% %Coefficient of restitution is the last input. Don't know how to calculate
% %it so I assumed it to be 0.63, which is the typical value of stainless
% %steel.
% [matrix] = Impact(angle_impact_slope,bouncing_time, X_after_proj,Y_after_proj,Contact_velocity, global_time,0.63); %Output is in a 3 matrix-columns matrix (x,y,t). Can add into a global array later.
% GlobalXYT = [GlobalXYT; matrix];

%Slope Part
slopeResults = slope(30,0.150);
GlobalXYT = [GlobalXYT; slopeResults];

%Projectile Part
projectileResults = projectile();
GlobalXYT = [GlobalXYT; projectileResults];

plot(GlobalXYT(:,1),GlobalXYT(:,2))
elapsedTime=GlobalXYT(end,3)

