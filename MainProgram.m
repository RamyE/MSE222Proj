% I am assuming standard metric units (metre, kg, second, N, etc...)
springK = 5;  %I don't what is its range or expected value
springS1 = 0.02;
springS2 = 0.035; %Assumed values given that S2 has to be larger than S1 (After spring is released)
%S2 is also considered the spring equilibrium position
mass = 0.05;

initialV = spring (springK, springS1, springS2, mass);
%the initial velocity in the X direction.
% we will start our initial X after the spring distance


%new comment
%new comment 2
%new comment 100