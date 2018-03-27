function [matrix]= Impact(angle,time,X,Y,v,global_time,c)
%Bounce functions are similiar to projtile function with decreasing
%velocity after each bounce.
matrix = [X,Y,global_time];
x0=X;
y0=Y;
x=X;
y=Y;
angle=angle*(pi./180);
velocity=v*c;
g=9.81;
localtime = 0;
timejump = 0.001; %Time step size is 1ms
t= 0.001;
while t < time %The period the ball will bounce, estimated by experiment.
    landingtime = (2*velocity*sin(pi/2 - angle))/(g*cos(angle)); %Total time to complete 1 bounce
    horizontal_proj_distance = ((2*velocity^2*sin(2*angle))/g) + x0; %Distance in X-axis of each bounce
    vertical_proj_distance = y0 + velocity*sin((pi/2)-2*angle)*landingtime - 0.5*g*landingtime^2; %Distance in Y-axis of each bounce
    
    if (x <= horizontal_proj_distance) && (x <= 100)
        localtime = localtime + timejump; %Local time of each bounce. t is the temp time (only use inside this function).
        x = velocity*cos((pi/2)-2*angle)*localtime + x0; %X Location equation
        y = velocity*sin((pi/2)-2*angle)*localtime - 0.5*g*localtime^2 + y0; %Y Location equation
        matrix = [matrix; x y (global_time+t)]; %Output.
        t= t + timejump;
    elseif (x > horizontal_proj_distance) && (y< vertical_proj_distance) %This check whether or not a bounce is completed and move to a new bounce.
        t = t - timejump;
        localtime=0;
        x0=x;
        y0=y;
        velocity=velocity*c;
    if round(velocity, 12) == 0
        break; %Exit the function if velocity become too small to return accurate reesult.
    end
    end
end
end
