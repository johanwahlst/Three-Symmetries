function [rmse_ZUPT,rmse_GP,rmse_NN,rmse_static] = performance(inertial,ground_truth,inds)

% Indices to align ground truth and inertial data.
gt_inds = temporal_alignment(inertial,ground_truth,0);

% % % % % % % % 
% Compute RMSE %
% % % % % % % %

rmse_ZUPT = sqrt(mean(sum((inertial.pos(1:2,inds)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)));
rmse_GP = sqrt(mean(sum((inertial.pos_GP(1:2,:)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)));
rmse_NN = sqrt(mean(sum((inertial.pos_NN(1:2,:)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)));
rmse_static = sqrt(mean(sum((inertial.pos_static(1:2,:)-ground_truth.pos(1:2,gt_inds(inds))).^2,1)));
