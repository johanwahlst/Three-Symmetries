function plot_position_vs_position_steps(inertial,ground_truth)

close all
figure('units','normalized','position',[0.76 0.4 0.423 0.5])
clf
inds_plot = find(ground_truth.steps(1,:)>-1.5);
p1 = plot(-10,-10);
hold on
for k = inds_plot
    p1 = plot(ground_truth.steps(1,k),ground_truth.steps(2,k),'color',zeros(1,3),'Marker','x','Linestyle','none','Linewidth',2,'MarkerSize',6);
end
for k = inds_plot
    p2 = plot(inertial.steps(1,k),inertial.steps(2,k),'color',[1 0 1],'Marker','s','Linestyle','none','Linewidth',1.5,'MarkerSize',6);
end
plot([inertial.steps(1,inds_plot)' ground_truth.steps(1,inds_plot)']',[inertial.steps(2,inds_plot)' ground_truth.steps(2,inds_plot)']','k-')
plot((-2:0.01:2),zeros(401,1),'k--')
plot(zeros(401,1),(-2:0.01:2),'k--')
grid on
axis([-1.5 2 -1.5 1.25])
xlabel('position [m]')
ylabel('position [m]')
legend([p1 p2],{'Ground truth','Model'},'Position',[0.693 0.135 0.15 0.13])

end