function plot_rmse_vs_time(inertial,ground_truth,inds)

gt_inds = temporal_alignment(inertial,ground_truth,0);

close all
fig = figure('units','normalized','position',[0.76 0.4 0.423 0.4]);

colors = [1 0 1; 1 0 0; 0 1 0; 0 0 1];

plot(inertial.t(inertial.step_seg(2:end))-inertial.t(inertial.step_seg(2)),sqrt(sum((inertial.pos(1:2,inds)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)),'color',colors(1,:),'Linewidth',1)
hold on
plot(inertial.t(inertial.step_seg(2:end))-inertial.t(inertial.step_seg(2)),sqrt(sum((inertial.pos_static(1:2,:)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)),'color',colors(2,:),'Linestyle','-.','Linewidth',2)
plot(inertial.t(inertial.step_seg(2:end))-inertial.t(inertial.step_seg(2)),sqrt(sum((inertial.pos_NN(1:2,:)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)),'color',colors(3,:),'Linestyle','--','Linewidth',2.5)
plot(inertial.t(inertial.step_seg(2:end))-inertial.t(inertial.step_seg(2)),sqrt(sum((inertial.pos_GP(1:2,:)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)),'color',colors(4,:),'Linestyle',':','Linewidth',2.5)

grid on
axis([0 282 0 6])
xlabel('Time [s]')
ylabel('Position error [m]')

legend({'Model','Model+static','Model+NN','Model+GP'},'Position',[0.27 0.595 0 0.3])

end
