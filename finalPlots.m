function finalPlots()

global GlobalXYT;

x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
time = GlobalXYT(:, 3);
vx = diff(GlobalXYT(1:end,1))./ diff(GlobalXYT(1:end,3));
vy = diff(GlobalXYT(1:end,2))./ diff(GlobalXYT(1:end,3));
ax = diff(vx)./ diff(time(1:end-1));
ay = diff(vy)./diff(time(1:end-1));

subplot(2,3,1)
x = x(~isnan(x) & isfinite(x));
% x = x(x<(mean(x)+3*std(x)));
plot(time(1:length(x)), x)
xlabel('Time')
ylabel('X position')
title('x wrt Time')

subplot(2,3,4)
y = y(~isnan(y) & isfinite(y));
% x = x(x<(mean(x)+3*std(x)));
plot(time(1:length(y)), y)
xlabel('Time')
ylabel('Y position')
title('y wrt Time')

subplot(2,3,2)
vx = vx(~isnan(vx) & isfinite(vx));
vx = vx(vx<(mean(vx)+3*std(vx)));
plot(time(1:length(vx)), vx)
xlabel('Time')
ylabel('Velocity in X direction')
title('Vx wrt Time')

subplot(2,3,5)
vy = vy(~isnan(vy) & isfinite(vy));
vy = vy(vy<(mean(vy)+3*std(vy)));
plot(time(1:length(vy)), vy)
xlabel('Time')
ylabel('Velocity in Y direction')
title('Vy wrt Time')

subplot(2,3,3)
ax = ax(~isnan(ax) & isfinite(ax));
ax = ax(ax<(mean(ax)+3*std(ax)));
plot(time(1:length(ax)), ax)
xlabel('Time')
ylabel('Acceleration in X direction')
title('Ax wrt Time')

subplot(2,3,6)
ay = ay(~isnan(ay) & isfinite(ay));
ay = ay(ay<(mean(ay)+3*std(ay)));
plot(time(1:length(ay)), ay)
xlabel('Time')
ylabel('Acceleration in Y direction')
title('Ay wrt Time')

end