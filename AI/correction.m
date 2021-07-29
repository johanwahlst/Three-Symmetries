function [inertial,inds] = correction(inertial,ground_truth,inds)

% % % % % % % % % 
% Pre-processing %
% % % % % % % % %

[inds,x,y_yaw,y_pos,inertial_euler] = corrections_preprocessing(inertial,ground_truth,inds);

% % % % % % % % % % % % % %
% Compute yaw corrections %
% % % % % % % % % % % % % %

[y_yaw_GP,y_yaw_NN,y_yaw_static] = compute_corrections(x,y_yaw);

% % % % % % % % % % % % % % % %
% Compute position corrections %
% % % % % % % % % % % % % % % %

% Initialize step corrections.
y_position_GP = zeros(size(y_pos));
y_position_NN = zeros(size(y_pos));
y_position_static = zeros(size(y_pos));

for spatial_direction = 1:3 
    
    [y_position_GP(spatial_direction,:),y_position_NN(spatial_direction,:),y_position_static(spatial_direction,:)] = compute_corrections(x,y_pos(spatial_direction,:));
    
end

% Display improvement in yaw estimates.
disp('RMSE [yaw] before correction')
disp(sqrt(mean((y_yaw).^2)))
disp('RMSE [yaw] after GP correction')
disp(sqrt(mean((y_yaw_GP-y_yaw).^2)))
disp('RMSE [yaw] after NN correction')
disp(sqrt(mean((y_yaw_NN-y_yaw).^2)))
disp('RMSE [yaw] after static correction')
disp(sqrt(mean((y_yaw_static-y_yaw).^2)))

% Display improvement in step estimates.
disp('RMSE [pos] before correction')
disp(sqrt(mean(sum((y_pos).^2,1))))
disp('RMSE [pos] after GP correction')
disp(sqrt(mean(sum((y_position_GP-y_pos).^2,1))))
disp('RMSE [pos] after NN correction')
disp(sqrt(mean(sum((y_position_NN-y_pos).^2,1))))
disp('RMSE [pos] after static correction')
disp(sqrt(mean(sum((y_position_static-y_pos).^2,1))))

inertial.pos_GP = corrections_postprocessing(y_yaw_GP,y_position_GP,inertial,inertial_euler,inds);
inertial.pos_NN = corrections_postprocessing(y_yaw_NN,y_position_NN,inertial,inertial_euler,inds);
inertial.pos_static = corrections_postprocessing(y_yaw_static,y_position_static,inertial,inertial_euler,inds);

end




