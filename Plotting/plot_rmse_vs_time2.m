function plot_rmse_vs_time2(rmse_ZUPT,rmse_static,rmse_NNs,rmse_GPs,range)

close all
figure('units','normalized','position',[0.76 0.4 0.423 0.4]);

colors = [1 0 1; 1 0 0; 0 1 0; 0 0 1];

plot(range-1,rmse_ZUPT*ones(1,length(range)),'color',colors(1,:),'Linewidth',1)
hold on
plot(range-1,rmse_static*ones(1,length(range)),'color',colors(2,:),'Linestyle','-.','Linewidth',2)
plot(range-1,mean(rmse_NNs,2),'color',colors(3,:),'Linestyle','-','Marker','o','Linewidth',2.5)
plot(range-1,mean(rmse_GPs,2),'color',colors(4,:),'Linestyle','-','Marker','+','Linewidth',2.5)

grid on
xlabel('Number of randomized rotations')
ylabel('Position error [m]')
xticks([range-1]);

legend({'Model','Model+static','Model+NN','Model+GP'},'Position',[0.27 0.595 0 0.3])

end