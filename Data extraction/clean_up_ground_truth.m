function ground_truth = clean_up_ground_truth(ground_truth)

    % Initialize ground truth Euler angles.
    ground_truth_euler = zeros(size(ground_truth.pos));
    
    % Compute ground truth Euler angles.
    for k = 1:size(ground_truth.pos,2)
        ground_truth_euler(:,k) = R2euler(ground_truth.R(:,:,k));
    end

    % Remove indices where the change in Euler angle is large.
    inds_to_remove = find(abs(diff(ground_truth_euler(1,:)))>0.3 | abs(diff(ground_truth_euler(2,:)))>0.3 | diff(unwrap(ground_truth_euler(3,:)))>0.3);
    inds_to_remove = [inds_to_remove inds_to_remove+1];

    % Keep all other indices.
    inds_to_keep = setdiff(1:length(ground_truth.t),inds_to_remove);

    % Compute new fields.
    ground_truth.t = ground_truth.t(inds_to_keep);
    ground_truth.pos = ground_truth.pos(:,inds_to_keep);
    ground_truth.R = ground_truth.R(:,:,inds_to_keep);

end

