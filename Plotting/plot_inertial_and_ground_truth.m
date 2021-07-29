function [] = plot_inertial_and_ground_truth(inds_inertial,inertial,ground_truth)

% Find inds for ground_truth.
inds_ground_truth = find(ground_truth.t < max(inertial.t(inds_inertial)) & ground_truth.t > min(inertial.t(inds_inertial)));

% % % % % % % % % % % % % % % % % % %
% Plot horizontal position estimates %
% % % % % % % % % % % % % % % % % % %

figure(1)
clf
plot(inertial.pos(1,inds_inertial),inertial.pos(2,inds_inertial))
hold on
plot(ground_truth.pos(1,inds_ground_truth),ground_truth.pos(2,inds_ground_truth))

axis equal
legend('inertial odometry','ground truth')
title('horizontal position estimates')

% % % % % % % % % % % % % % % % % %
% Plot vertical position estimates %
% % % % % % % % % % % % % % % % % %

figure(2)
clf
plot(inertial.t(inds_inertial)-inertial.t(inds_inertial(1)),inertial.pos(3,inds_inertial))
hold on
plot(ground_truth.t(inds_ground_truth)-inertial.t(inds_inertial(1)),ground_truth.pos(3,inds_ground_truth))
legend('inertial odometry','ground truth')
title('vertical position estimates vs time')

% % % % % % % % % % % 
% Plot Euler angles %
% % % % % % % % % % %

inertial_euler = zeros(3,size(inertial.t,2));
ground_truth_euler = zeros(3,size(ground_truth.t,2));

for k = 1:size(inertial.t,2)
    inertial_euler(:,k) = R2euler(inertial.R(:,:,k));    
end

for k = 1:size(ground_truth.t,2)
    ground_truth_euler(:,k) = R2euler(ground_truth.R(:,:,k));
end

% Roll angle

figure(3)
clf
plot(inertial.t(inds_inertial),inertial_euler(1,inds_inertial))
hold on
plot(ground_truth.t(inds_ground_truth),ground_truth_euler(1,inds_ground_truth))
legend('inertial odometry','ground truth')
title('roll angle estimates vs time')

% Pitch angle

figure(4)
clf
plot(inertial.t(inds_inertial),inertial_euler(2,inds_inertial))
hold on
plot(inertial.t(inds_inertial),inertial.zupt(inds_inertial),'k*')
plot(ground_truth.t(inds_ground_truth),ground_truth_euler(2,inds_ground_truth))
legend('inertial odometry','ground truth')
title('pitch angle estimates vs time')

% Yaw angle

figure(5)
clf
plot(inertial.t(inds_inertial),inertial_euler(3,inds_inertial))
hold on
plot(ground_truth.t(inds_ground_truth),ground_truth_euler(3,inds_ground_truth))
legend('inertial odometry','ground truth')
title('yaw angle estimates vs time')
