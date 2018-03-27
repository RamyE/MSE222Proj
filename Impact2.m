function [matrix]= Impact2(angle, time, X, Y, global_time, c)
%Bounce functions are similiar to projtile function with decreasing
%velocity after each bounce.
%Time: The total time the ball takes to bounce in seconds
matrix = [X,Y,global_time];
global GlobalXYT;
Vx = (GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
Vy = (GlobalXYT(end,2) - GlobalXYT(end-1,2))/(GlobalXYT(end,3) - GlobalXYT(end-1,3));
velocity = sqrt(Vx.^2 + Vy.^2); %calculating the initial velocity from the last element data
x0=X;
y0=Y;
x=X;
y=Y;
angle=angle*(pi./180);
velocity=14*c; %As the velocity calculated from the curved part is abnormally large. I will use this dummy value for the time being.
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
    if round(velocity, 5) == 0
        break; %Exit the function if velocity become too small to return accurate result.
    end
end
%figure;
%plot(matrix(:,1), matrix(:,2), 'b')
%xlabel('X')
%ylabel('Y')
%xlim([0, 12])
%ylim([0, 12])
%title('Y versus X of Impact projectile')
%hold on
end
