clear, clc, clearvars
close all

[x1,x2,y1,y2] = hor_bounce(0.05,0.005,0.1,2,1,50,40,3,2);
figure;
plot(x1, y1,'--b')
xlabel('X')
ylabel('Y')
% xlim([0, 100])
% ylim([-100, 0])
hold on
title('Y versus X of horizontal collision')
plot (x2, y2, 'r','marker','<')
hold off
