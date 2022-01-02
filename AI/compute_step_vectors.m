function [inertial,ground_truth] = compute_step_vectors(inertial,ground_truth)

% Initialize fields.
inertial.steps = zeros(3,length(inertial.step_seg)-1);
inertial.steps_pos = zeros(3,length(inertial.step_seg));
inertial.steps_euler = zeros(3,length(inertial.step_seg));
ground_truth.steps = zeros(3,length(inertial.step_seg)-1);
ground_truth.steps_pos = zeros(3,length(ground_truth.step_seg));
ground_truth.steps_euler = zeros(3,length(ground_truth.step_seg));

% Compute values at first time step.
k = 1;
inertial.steps_euler(:,k) = R2euler(inertial.R(:,:,inertial.step_seg(k)));
ground_truth.steps_euler(:,k) = R2euler(ground_truth.R(:,:,ground_truth.step_seg(k)));
inertial.steps_pos(:,k) = inertial.pos(:,inertial.step_seg(k));
ground_truth.steps_pos(:,k) = ground_truth.pos(:,ground_truth.step_seg(k));

% Iterate over indices.
for k = 2:length(inertial.step_seg)

    % Compute step vectors.
    inertial.steps(:,k-1) = inertial.R(:,:,inertial.step_seg(k-1))'*(inertial.pos(:,inertial.step_seg(k))-inertial.pos(:,inertial.step_seg(k-1)));
    inertial.steps_pos(:,k) = inertial.pos(:,inertial.step_seg(k));
    inertial.steps_euler(:,k) = R2euler(inertial.R(:,:,inertial.step_seg(k)));
    
    ground_truth.steps(:,k-1) = ground_truth.R(:,:,ground_truth.step_seg(k-1))'*(ground_truth.pos(:,ground_truth.step_seg(k))-ground_truth.pos(:,ground_truth.step_seg(k-1)));
    ground_truth.steps_pos(:,k) = ground_truth.pos(:,ground_truth.step_seg(k));
    ground_truth.steps_euler(:,k) = R2euler(ground_truth.R(:,:,ground_truth.step_seg(k)));
    
end
    
end

