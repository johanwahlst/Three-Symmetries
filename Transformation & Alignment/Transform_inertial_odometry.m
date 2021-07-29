function inertial = Transform_inertial_odometry(inertial,ground_truth)

initial_value = zeros(1,4);

% Find the first index with both inertial and ground truth measurements.
if(inertial.t(1)<ground_truth.t(1))
    a = find(inertial.t>ground_truth.t(1),1);
else
    temp_a = find(inertial.t(1)<ground_truth.t,1);
    a = find(inertial.t>ground_truth.t(temp_a),1);
end

% The last index to use for calibration.
b = find(sqrt(sum((inertial.pos(:,1)-inertial.pos).^2,1))>3,1);

% The indices to use for calibration.
indices = setdiff(a:b,find(inertial.zupt==1));

inds = temporal_alignment(inertial,ground_truth,0);

% Defining the optimization function.
fun = @(x) ground_truth.pos(:,inds(indices))-(Rotation_matrix([pi 0 x(1)])*inertial.pos(1:3,indices)+x(2:4)'*ones(1,length(indices)));

% Options for suppressing output.
options = optimset('display','off');

% Performing the optimization.
x = lsqnonlin(fun,initial_value,[],[],options);

% Defining the rotation matrix that will be applied to the inertial measurements.
R = Rotation_matrix([pi 0 x(1)]);

% Rotating and translating the position estimates produced by the inertial odometry.
inertial.pos(1:3,:) = R*inertial.pos(1:3,:)+x(2:4)'*ones(1,size(inertial.pos,2));

% Rotating the orientation estimates produced by the inertial odometry.
for k = 1:size(inertial.pos,2)
    inertial.R(:,:,k) = R*inertial.R(:,:,k);
end

end

