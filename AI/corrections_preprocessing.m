function [inds,x,y_yaw,y_pos,inertial_euler] = corrections_preprocessing(inertial,ground_truth,inds)

% % % % % % % % % % % % % % % % % % % % % % %
% Compute indices where to apply correction %
% % % % % % % % % % % % % % % % % % % % % % %

% Indices to align ground truth and inertial data.
gt_inds = temporal_alignment(inertial,ground_truth,0);

% Remove indices where inertial and ground truth data differ a lot.
inds = inds(abs(inertial.t(inds)-ground_truth.t(gt_inds(inds)))<0.1);

% % % % % % % % % % % % % % % % % % % % %
% Compute training input for corrections %
% % % % % % % % % % % % % % % % % % % % %

% Compute steps from zupt-aided inertial odometry.
x = zeros(3,length(inds)-1);
for k = 2:length(inds)
    x(:,k-1) = inertial.R(:,:,inds(k-1))'*(inertial.pos(:,inds(k))-inertial.pos(:,inds(k-1)));
end

% % % % % % % % % % % % % % % % % % % % % % % % %
% Compute training output for corrections (yaw) %
% % % % % % % % % % % % % % % % % % % % % % % % %

% Compute Euler angles from zupt-aided inertial odometry.
inertial_euler = zeros(3,length(inds));
for k = 1:length(inds)
    inertial_euler(:,k) = R2euler(inertial.R(:,:,inds(k)));
end

% Compute Euler angles from ground truth.
ground_truth_euler = zeros(3,length(inds));
for k = 1:length(inds)
    ground_truth_euler(:,k) = R2euler(ground_truth.R(:,:,gt_inds(inds(k))));
end

% Compute error in incremental yaw.
y_yaw = diff(unwrap(ground_truth_euler(3,:)))-diff(unwrap(inertial_euler(3,:)));

% % % % % % % % % % % % % % % % % % % % % % % % % % %
% Compute training output for corrections (position) %
% % % % % % % % % % % % % % % % % % % % % % % % % % %

% Compute steps from ground truth.
ground_truth_step = zeros(3,length(inds)-1);
for k = 2:length(inds)
    ground_truth_step(:,k-1) = ground_truth.R(:,:,gt_inds(inds(k-1)))'*(ground_truth.pos(:,gt_inds(inds(k)))-ground_truth.pos(:,gt_inds(inds(k-1))));
end

% Compute error in step estimates.
y_pos = ground_truth_step-x;

end

