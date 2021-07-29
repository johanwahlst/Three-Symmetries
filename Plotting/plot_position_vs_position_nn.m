function plot_position_vs_position_nn(inertial)

spat_align = [-0.9 0.1];

colors = [1 0 1; 1 0 0; 0 1 0; 0 0 1];

close all
figure('units','normalized','position',[0.76 0.3 0.423 0.44])
clf
plot(inertial.pos_NN(2,:)+spat_align(1),inertial.pos_NN(1,:)+spat_align(2),'color',colors(3,:),'Linestyle','-','Marker','o','Linewidth',2.5)
hold on

yticks(-2:2)

grid on
axis([-4 4 -2.5 2])
xlabel('position [m]')
ylabel('position [m]')

end