function plot_position_vs_position_trajectory(ground_truth)

spat_align = [-0.9 0.1];

close all
fig = figure('units','normalized','position',[0.56 0.4 0.423 0.4]);
plot(ground_truth.pos(2,:)+spat_align(1),ground_truth.pos(1,:)+spat_align(2),'color',0.4*[1 1 1],'Linewidth',1)
hold on
plot(ground_truth.pos(2,1)+spat_align(1),ground_truth.pos(1,1)+spat_align(2),'kx','Linewidth',3,'Markersize',10)

grid on
axis([-3.5 3.5 -2 2])
xlabel('position [m]')
ylabel('position [m]')
yticks(-2:2)
xticks(-4:4)

end