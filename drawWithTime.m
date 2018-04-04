function drawWithTime()
global GlobalXYT;
%plot(GlobalXYT(1,1), GlobalXYT(1,2),'o', 'MarkerSize', 15, 'MarkerFaceColor','r')
     axis([0 0.3048 0 0.3048]); %has to be changed
 an = animatedline;
 for i = 2:20:length(GlobalXYT)
    hold off;
     %addpoints(an, GlobalXYT(i,1), GlobalXYT(i,2))
     %hold on;
     plot(GlobalXYT(i,1), GlobalXYT(i,2),'o', 'MarkerSize', 12, 'MarkerFaceColor','r')
     %drawnow;
     axis([0 0.3048 0 0.3048]); %has to be changed
     pause((GlobalXYT(i,3)-GlobalXYT(i-1,3)));
 end
 
 %an = animatedline(GlobalXYT(:,1),GlobalXYT(:,2))
