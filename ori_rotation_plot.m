clear, clc, clearvars
close all
% global GlobalXYT;
[x,y,t] = ori_rotation(0.05,0.005,0.0125,0.06,0.3);
figure;
plot(x,y)
xlabel('X')
ylabel('Y')
% xlim([0, 100])
% ylim([-100, 0])
hold on