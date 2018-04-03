function loseEnergy()
global GlobalXYT;

GlobalXYT(end+1,1:2) = GlobalXYT(end,1:2); GlobalXYT(end,3) = GlobalXYT(end-1,3)+0.001;
GlobalXYT(end+1,1:2) = GlobalXYT(end,1:2);GlobalXYT(end,3) = GlobalXYT(end-1,3)+0.001;
GlobalXYT(end+1,1:2) = GlobalXYT(end,1:2);GlobalXYT(end,3) = GlobalXYT(end-1,3)+0.001;
GlobalXYT(end+1,1:2) = GlobalXYT(end,1:2);GlobalXYT(end,3) = GlobalXYT(end-1,3)+0.001;
GlobalXYT(end+1,1:2) = GlobalXYT(end,1:2);GlobalXYT(end,3) = GlobalXYT(end-1,3)+0.001;

end