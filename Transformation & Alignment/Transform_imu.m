function [inertial,ground_truth] = Transform_imu(inertial,ground_truth,initial_value)

% Define the objective function.
fun = @(x) Euler_mse(x,inertial,ground_truth);

% Options for suppressing output.
options = optimset('display','off');

% Perform the optimization.
x = lsqnonlin(fun,initial_value,[],[],options);

% Define the rotation matrix that will be applied to the inertial measurements.
R = Rotation_matrix(x);

% Rotate the orientation estimates produced by the inertial odometry.
for k = 1:size(inertial.pos,2)
    inertial.R(:,:,k) = inertial.R(:,:,k)*R;
end

% Compute Euler angles.
dts = -0.1:0.01:0.1;
temporal_mses = zeros(length(dts),2);
for k = 1:size(inertial.t,2)
    inertial_euler(:,k) = R2euler(inertial.R(:,:,k));    
end
for k = 1:size(ground_truth.t,2)
    ground_truth_euler(:,k) = R2euler(ground_truth.R(:,:,k));
end

% Iterate over different temporal delays.
for i = 1:length(dts)

    disp(i)
    dt = dts(i);
    temp_inds = temporal_alignment(inertial,ground_truth,dt);
    ground_truth_temp.inds = temp_inds;
    temporal_mses(i,:) = sum((inertial_euler(1:2,:)-ground_truth_euler(1:2,ground_truth_temp.inds)).^2,2);
    
end

% Optimization with respect to temporal delay.
[~,i] = min(sum(temporal_mses,2));
temp_inds = temporal_alignment(inertial,ground_truth,dts(i));
ground_truth.inds = temp_inds;
inertial.t = inertial.t+dts(i);

end

