function drawWithTime()
global GlobalXYT;
 plot(GlobalXYT(1,1), GlobalXYT(1,2),'o');
 for i = 2:100:length(GlobalXYT)
     plot(GlobalXYT(i,1), GlobalXYT(i,2),'o', 'MarkerSize', 15);
     drawnow;
     axis([-5 5 -5 5]); %has to be changed
     pause((GlobalXYT(i,3)-GlobalXYT(i-1,3))*1000);
 end