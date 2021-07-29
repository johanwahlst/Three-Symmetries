addpath(genpath(pwd));

% % % % % % %  
%% Load data %
% % % % % % % 

[inertial,ground_truth] = load_data(15);

% % % % % % % % % % % % % % % %
%% Clean up ground truth data %
% % % % % % % % % % % % % % % %

ground_truth = clean_up_ground_truth(ground_truth);

% % % % % % % % % % % %
%% Run ZUPT-aided INS %
% % % % % % % % % % % %

inertial = smoothed_ZUPTaidedINS(inertial);

% % % % % % % % % % % 
%% Step segmentation %
% % % % % % % % % % % 

[inertial,ground_truth] = step_segmentation(inertial,ground_truth);

% % % % % % % % % % % % % %
%% Plot step segmentation %
% % % % % % % % % % % % % %

plot_step_segmentation(inertial,ground_truth); 

% % % % % % % % % % % % % % % % % % % % % % % % % %
%% Transform the navigation frame of inertial data %
% % % % % % % % % % % % % % % % % % % % % % % % % %

inertial = Transform_inertial_odometry(inertial,ground_truth);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%% Transform the inertial frame and perform temporal alignment %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

[inertial,ground_truth] = Transform_imu(inertial,ground_truth,zeros(3,1));

% % % % % % % % % % % % % % % % % % % % % % 
%% Plot inertial odometry and ground truth %
% % % % % % % % % % % % % % % % % % % % % %
 
plot_inertial_and_ground_truth(1:length(inertial.t),inertial,ground_truth)

% % % % % % % % % % % % % % % % % % %
%% Load data obtained at this point %
% % % % % % % % % % % % % % % % % % %

load('data')

% % % % % % % % % % % % % % % % % % % % % % % % % %
%% Article plot: position vs position (trajectory) %
% % % % % % % % % % % % % % % % % % % % % % % % % %

plot_position_vs_position_trajectory(ground_truth)

% % % % % % % % % % % % % % % % % % % % % % % % % 
%% Article plot: trajectory from ZUPT-aided INS %
% % % % % % % % % % % % % % % % % % % % % % % % %

plot_position_vs_position_trajectory_zupt(inertial)

% % % % % % % % % % % % % % % % % % % % 
%% Article plot: trajectory comparison %
% % % % % % % % % % % % % % % % % % % %

plot_position_vs_position_trajectory_comparison(inertial,ground_truth)

% % % % % % % % % % % % %
%% Compute step vectors %
% % % % % % % % % % % % %

[inertial,ground_truth] = compute_step_vectors(inertial,ground_truth);

% % % % % % % % % % % % % % % % % % % % % % % % 
%% Article plot: position vs position (steps) %
% % % % % % % % % % % % % % % % % % % % % % % %

plot_position_vs_position_steps(inertial,ground_truth)

% % % % % % % % % % % % % % % % % % % % % % % % %
%% Choose indices where correction is to be made %
% % % % % % % % % % % % % % % % % % % % % % % % %

inds = inertial.step_seg;

% % % % % % % % % % % %
%% ZUPT + corrections %
% % % % % % % % % % % %

[inertial,inds] = correction(inertial,ground_truth,inds);

% % % % % % % % 
%% Performance % 
% % % % % % % %

[rmse_ZUPT,rmse_GP,rmse_NN,rmse_static] = performance(inertial,ground_truth,inds)

% % % % % % % % % % % % % % % %
%% Article plot: rmse vs time %
% % % % % % % % % % % % % % % %

plot_rmse_vs_time(inertial,ground_truth,inds)

% % % % % % % % % % % % % % % % % % % % % % % %  
%% Article plot: trajectory from NN correction %
% % % % % % % % % % % % % % % % % % % % % % % % 

plot_position_vs_position_nn(inertial)

% % % % % % % % % % % % % % % % % % % % % % % % % % %
%% Compute performance for different time divisions %
% % % % % % % % % % % % % % % % % % % % % % % % % % %

[rmse,dt_inds] = corrections_with_different_time_divisions(inertial,ground_truth);

% % % % % % % % % % % % % % % % % % %
%% Load data obtained at this point %
% % % % % % % % % % % % % % % % % % %

load('results')

% % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%% Article plot: rmse vs time (sampling window length) %
% % % % % % % % % % % % % % % % % % % % % % % % % % % %

plot_rmse_vs_time_sampling_window_length(rmse,dt_inds)
