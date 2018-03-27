function [matrix]= Impact2(angle, time, X, Y, v, global_time, c)
%Bounce functions are similiar to projtile function with decreasing
%velocity after each bounce.
%Time: The period the ball will bounce, estimated by experiment.
matrix = [X,Y,global_time];
x0=X;
y0=Y;
x=X;
y=Y;
angle=angle*(pi./180);
velocity=v*c;
g=9.81;
localtime = 0;
timejump = 0.001; %Time step size is 1 ms
t= 0.000;
while (t <= time) 
    landingtime = (2*velocity*sin(pi/2 - angle))/(g*cos(angle)); %Total time to complete 1 bounce
    if (localtime <= landingtime) %This check whether or not a bounce is completed and move to a new bounce.
        localtime = localtime + timejump; %Local time of each bounce. t is the temp time (only use inside this function).
        t= t + timejump;
        x = velocity*cos((pi/2)-2*angle)*localtime + x0; %X Location equation
        y = velocity*sin((pi/2)-2*angle)*localtime - 0.5*g*localtime^2 + y0; %Y Location equation
        matrix = [matrix; x y (global_time+t)]; %Output.     
    else 
        localtime=0;
        x0=x;
        y0=y;
        velocity=velocity*c;
    end
    if round(velocity, 11) == 0
        break; %Exit the function if velocity become too small to return accurate result.
    end
end
end
