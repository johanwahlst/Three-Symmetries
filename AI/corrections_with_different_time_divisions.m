function [rmse,dt_inds] = corrections_with_different_time_divisions(inertial,ground_truth)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Compute performance for different lengths between corrections %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Vector with fixed time lengths. 
dt_inds = 80:10:160;

% Initialize vectors with rmses.
rmse.GP_fixed_time_length = zeros(size(dt_inds));
rmse.NN_fixed_time_length = zeros(size(dt_inds));
rmse.static_fixed_time_length = zeros(size(dt_inds));

% Iterate over the the different time lengths.
for k = 1:length(dt_inds)
    disp(k)
    dt = dt_inds(k);
    inds = 1:dt:length(inertial.t);
    [inertial,inds] = correction(inertial,ground_truth,inds);
    [rmse.ZUPT,rmse.GP_fixed_time_length(k),rmse.NN_fixed_time_length(k),rmse.static_fixed_time_length(k)] = performance(inertial,ground_truth,inds);
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Compute performance with correction length based on steps %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

inds = inertial.step_seg;
[inertial,inds] = correction(inertial,ground_truth,inds);
[~,rmse.GP_step_based_time_length,rmse.NN_step_based_time_length,rmse.static_step_based_time_length] = performance(inertial,ground_truth,inds);

end

