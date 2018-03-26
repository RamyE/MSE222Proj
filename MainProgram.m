clc
clear global;
close all;

%This is a list of constants that is dependent on the design (START)
% I am assuming standard metric units (metre, kg, second, N, etc...)


initialX = 0.05; %Assuming arounf 5 cm from left - Value after the spring release position
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
initialV = spring (springK, springS1, springS2, mass);
%the initial velocity in the X direction.
%We will start our initial X after the spring distance
