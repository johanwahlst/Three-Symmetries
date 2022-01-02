function plot_position_vs_position_trajectory_comparison(inertial,ground_truth)

spat_align = [-0.9 0.1];

colors = [1 0 1; 1 0 0; 0 1 0; 0 0 1];

inds_inertial = 1:1000;

% Find inds for ground_truth.
inds_ground_truth = find(ground_truth.t < max(inertial.t(inds_inertial)) & ground_truth.t > min(inertial.t(inds_inertial)));

close all
figure('units','normalized','position',[0.76 0.3 0.423 0.5])
clf
plot(inertial.pos(2,inds_inertial)+spat_align(1),inertial.pos(1,inds_inertial)+spat_align(2),'color',0.4*[1 1 1],'Linewidth',1.5)
hold on
plot(ground_truth.pos(2,inds_ground_truth)+spat_align(1),ground_truth.pos(1,inds_ground_truth)+spat_align(2),'color',colors(1,:),'Linewidth',1.5)

clc

xticks(-2:0.5:2)
yticks(-2:0.5:2)

grid on
axis([-1 1.5 0 2])
xlabel('position [m]')
ylabel('position [m]')
legend({'Ground truth','Model'},'Position',[0.693 0.135 0.15 0.13])

end