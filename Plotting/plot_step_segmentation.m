function [] = plot_step_segmentation(inertial,ground_truth)

% Plot time points and accelerometer power at step detections.
figure(1)
clf
plot(inertial.t,sum(inertial.u(1:3,:).^2,1))
hold on
plot(inertial.t(inertial.step_seg),100,'rx')
legend('accelerometer power','detected steps')
title('Step detection')

% Plot sampling instances allocated to each step.
figure(2)
clf
plot(inertial.t(inertial.step_seg(1:end-1)),diff(inertial.step_seg))
title('Sampling instances (of inertial data) for each step')

% Plot difference in time (inertial vs ground truth) at step detections.
figure(3)
clf
plot(inertial.t(inertial.step_seg),inertial.t(inertial.step_seg)-ground_truth.t(ground_truth.step_seg))
title('Difference in time (inertial vs ground truth) at step detections')

% Plot time length between ground truth sampling instances.
figure(4)
clf
plot(ground_truth.t(1:end-1),diff(ground_truth.t))
title('Length between ground truth sampling instances')

% Plot spatial length of steps.
figure(5)
clf
plot(ground_truth.t(ground_truth.step_seg(1:end-1)),sqrt(sum((diff(ground_truth.pos(:,ground_truth.step_seg)')).^2,2)))
hold on
plot(inertial.t(inertial.step_seg(1:end-1)),sqrt(sum((diff(inertial.pos(:,inertial.step_seg)')).^2,2)))
title('Length of steps')
legend('ground truth','inertial odometry')

end

