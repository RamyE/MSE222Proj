function [result]= Impact_up_left(angle, X, Y, global_time, c)
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
Vx = c*abs((GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3))); %Use this for real model.
Vy = c*abs((GlobalXYT(end,2) - GlobalXYT(end-1,2))/(GlobalXYT(end,3) - GlobalXYT(end-1,3)));
velocity = sqrt(Vx.^2 + Vy.^2); %calculating the initial velocity from the last element data
x0=X;
y0=Y;
x=X;
y=Y;
angle=angle*(pi./180); %slope angle
%Dummy Value
velocity=10*c; %I will use this dummy value for the time being.
Vx = -velocity*cos((pi/180)*80); %Positive for downward bounce.
Vy = velocity*sin((pi/180)*80);
%End dummy value
contact_angle = acot(abs(Vx)/Vy); %Contact angle change after each bounce.
landingtime = (2*velocity*sin(contact_angle - angle))/(g*cos(angle)); %Total time to complete 1 bounce. Change minus to plus for downward bounce.
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
        Vy = abs((Vy - g*landingtime)*c);
        Vx = Vx*c;
        velocity=(sqrt((Vx^2) + (Vy^2))); %New bounce velocity
        contact_angle = acot(Vx/Vy); %Contact angle change after each bounce.
        landingtime = (2*velocity*sin(contact_angle + angle))/(g*cos(angle)); %Total time to complete 1 bounce
    end
    if round(landingtime, 2) == 0
        stop = true;
        break; %Exit the function if the flying time become too small.
    end
end
figure;
plot(result(:,1), result(:,2), 'b')
xlabel('X')
ylabel('Y')
xlim([0.1, 12])
ylim([0, 12])
title('According to the slow motion video. The ball is bouncing up.')
grid on
grid minor
hold on
end
