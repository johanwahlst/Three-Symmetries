function mses = Euler_mse(angles,inertial,ground_truth)

% Find the first index with both inertial and ground truth measurements.
if(inertial.t(1)<ground_truth.t(1))
    a = find(inertial.t>ground_truth.t(1),1);
else
    temp_a = find(inertial.t(1)<ground_truth.t,1);
    a = find(inertial.t>ground_truth.t(temp_a),1);
end

% The last index to use for yaw calibration.
b = find(sqrt(sum((inertial.pos(:,1)-inertial.pos).^2,1))>3,1);

% The indices to use for yaw calibration.
indices = setdiff(a:b,find(inertial.zupt==1));

% Define the rotation matrix applied to the inertial odometry.
R = Rotation_matrix(angles);

% Rotate the orientation estimates from the inertial odometry.
for k = 1:size(inertial.pos,2)
    inertial.R(:,:,k) = inertial.R(:,:,k)*R;
end

% Initialize matrices for Euler angles.
inertial_euler = zeros(3,size(inertial.t,2));
ground_truth_euler = zeros(3,size(ground_truth.t,2));

% Computer Euler angles from inertial odometry.
for k = 1:size(inertial.t,2)
    inertial_euler(:,k) = R2euler(inertial.R(:,:,k));    
end

% Computer Euler angles from ground truth estimates.
for k = 1:size(ground_truth.t,2)
    ground_truth_euler(:,k) = R2euler(ground_truth.R(:,:,k));
end

% Find the indices with zero velocity.
in = find(inertial.zupt==1);

% Compute the mean-square error of the Euler angle estimates.
mses = [];
inds = temporal_alignment(inertial,ground_truth,0);
for i = 1:2
    mse = min(abs([inertial_euler(i,in)-ground_truth_euler(i,inds(in)); inertial_euler(i,in)-ground_truth_euler(i,inds(in))+2*pi; inertial_euler(i,in)-ground_truth_euler(i,inds(in))-2*pi]));
    mses = [mses mse];
end
i = 3;
mse = min(abs([inertial_euler(i,indices)-ground_truth_euler(i,inds(indices)); inertial_euler(i,indices)-ground_truth_euler(i,inds(indices))+2*pi; inertial_euler(i,indices)-ground_truth_euler(i,inds(indices))-2*pi]));
mses = [mses mse];

end

