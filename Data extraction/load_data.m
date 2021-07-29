function [inertial,ground_truth] = load_data(num)

% % % % % % % % % % % % % 
% Extract inertial data %
% % % % % % % % % % % % %

inertial = extract_inertial_data(num);

% % % % % % % % % % % % % % % 
% Extract ground truth data %
% % % % % % % % % % % % % % % 

ground_truth = extract_ground_truth_data(num);

