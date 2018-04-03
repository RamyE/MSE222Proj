function [result]= Impact_temp(angle, X, Y, global_time, c)
%Bounce functions are similiar to projtile function with decreasing
%velocity after each bounce.
%Time: The total time the ball takes to bounce in seconds
result = [X,Y,global_time];
global GlobalXYT;
g=9.81;
localtime = 0;
timejump = 0.001; %Time step size is 1 ms
t= 0.000;
stop = false;
angle=angle*(pi./180); %slope angle
Vx = abs((GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3)))*c;
Vy = abs((GlobalXYT(end,2) - GlobalXYT(end-1,2))/(GlobalXYT(end,3) - GlobalXYT(end-1,3)))*c;
velocity = sqrt(Vx.^2 + Vy.^2); %calculating the initial velocity from the last element data
x0=X;
y0=Y;
x=X;
y=Y;



% Dummy Value
velocity=14; %As the velocity calculated from the curved part is abnormally large. I will use this dummy value for the time being.
Vx = velocity*cos(24*(pi./180)); 
Vy = velocity*sin(24*(pi./180));



%Real contact will be acot(vx/vy) + 2*angle, not the one below.
contact_angle = acot(Vx/Vy) %Contact angle change after each bounce.
i=pi/2 - angle - contact_angle
reflect_angle = atan(tan(i)/c)
reflect_angle_to_the_ground = pi/2 + angle - reflect_angle
velocity = sqrt((velocity^2)*((c^2)*(cos(i)^2) + (sin(i)^2)))
Vx = velocity*cos(reflect_angle_to_the_ground)
Vy = velocity*sin(reflect_angle_to_the_ground)

use_this_crap_for_flying_time = pi/2 - reflect_angle;
landingtime = (2*velocity*sin(use_this_crap_for_flying_time))/(g*cos(angle)) %Total time to complete 1 bounce


%Debug crap
xd = Vx*landingtime; %X Location equation
yd = Vy*landingtime - 0.5*g*landingtime^2; %Y Location equation
slope_angle = acot((xd)/(yd));
count =0;
%End of debug crap
while (stop == false)
    if (localtime <= landingtime) %This check whether or not a bounce is completed and move to a new bounce.
        localtime = localtime + timejump; %Local time of each bounce. t is the temp time (only use inside this function).
        t= t + timejump;
        x = Vx*localtime + x0; %X Location equation
        y = Vy*localtime - 0.5*g*localtime^2 + y0; %Y Location equation
        result = [result; x y (global_time+t)]; %Output.  
    else 
        localtime=0;
        x0=x;
        y0=y;
        Vy = -(Vy - g*landingtime)
        velocity = sqrt((Vx^2) + (Vy^2)) %New bounce velocity
        contact_angle = acot(Vx/Vy) %Contact angle change after each bounce.
        i=pi/2 - angle - contact_angle
        reflect_angle = atan(tan(i)/c)
        reflect_angle_to_the_ground = pi/2 + angle - reflect_angle
        velocity = sqrt((velocity^2)*((c^2)*(cos(i)^2) + (sin(i)^2)))
        Vx = velocity*cos(reflect_angle_to_the_ground)
        Vy = velocity*sin(reflect_angle_to_the_ground)
        use_this_crap_for_flying_time = pi/2 - reflect_angle
        landingtime = (2*velocity*sin(use_this_crap_for_flying_time))/(g*cos(angle)) %Total time to complete 1 bounce
        count = count +1;
        reflect_angle_to_the_ground - angle
        
        
    end
    if (reflect_angle_to_the_ground - angle) <= 0.001
        stop = true;
        break; %Exit the function if the contact angle become too close to slope angle.
    end
end
figure;
plot(result(:,1), result(:,2), 'r')
xlabel('X')
ylabel('Y')
xlim([-30, 12])
ylim([-30, 12])
title('Y versus X of Impact-up Bounce Projectile')
grid on
grid minor
hold on
end
