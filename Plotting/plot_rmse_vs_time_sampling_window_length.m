function plot_rmse_vs_time_sampling_window_length(rmse,dt_inds)

colors = [1 0 1; 1 0 0; 0 1 0; 0 0 1];

close all
figure('units','normalized','position',[0.56 0.3 0.423 0.55])
clf
plot(dt_inds,ones(size(dt_inds))*rmse.ZUPT,'color',colors(1,:),'Linewidth',1.5)
hold on
plot(dt_inds,rmse.static_fixed_time_length,'color',colors(2,:),'Linestyle','-','Marker','x','Linewidth',2)
plot(dt_inds,rmse.NN_fixed_time_length,'color',colors(3,:),'Linestyle','-','Marker','o','Linewidth',2.5)
plot(dt_inds,rmse.GP_fixed_time_length,'color',colors(4,:),'Linestyle','-','Marker','+','Linewidth',2.5)
plot(dt_inds,ones(size(dt_inds))*rmse.static_step_based_time_length,'color',colors(2,:),'Linestyle','-.','Linewidth',2)
plot(dt_inds,ones(size(dt_inds))*rmse.NN_step_based_time_length,'color',colors(3,:),'Linestyle','--','Linewidth',2.5)
plot(dt_inds,ones(size(dt_inds))*rmse.GP_step_based_time_length,'color',colors(4,:),'Linestyle',':','Linewidth',2.5)

grid on
axis([80 150 0.5 3.5])
xlabel('xlabel')
ylabel('ylabel')

legend({'Model','Model+static (fixed)','Model+NN (fixed)','Model+GP (fixed)','Model+static (adaptive)','Model+NN (adaptive)','Model+GP (adaptive)'},'Position',[0.444 0.55 0.15 0.35])

end