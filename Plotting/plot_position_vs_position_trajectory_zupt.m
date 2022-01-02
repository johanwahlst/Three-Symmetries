function plot_position_vs_position_trajectory_zupt(inertial)

spat_align = [-0.9 0.1];

colors = [1 0 1; 1 0 0; 0 1 0; 0 0 1];

close all
figure('units','normalized','position',[0.76 0.3 0.423 0.55])
clf
plot(inertial.pos(2,:)+spat_align(1),inertial.pos(1,:)+spat_align(2),'color',colors(1,:),'Linewidth',1.5)

grid on
axis([-4 4 -3 4.5])
xlabel('position [m]')
ylabel('position [m]')

end