clear, clc, clearvars
close all
global GlobalXYT;
[result] = rotation(0.05,0.005,0.0125,0.06,0.09);
figure;
plot(result(:,1), result(:,2), 'b')
xlabel('X')
ylabel('Y')
% xlim([0, 100])
% ylim([-100, 0])
hold on