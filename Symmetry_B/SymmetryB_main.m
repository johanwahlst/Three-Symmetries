function [rmse_ZUPT,rmse_GPs,rmse_NNs,rmse_static] = SymmetryB_main(inertial,ground_truth,inds,range)

repetitions = 10;

rmse_GPs = zeros(length(range),repetitions);
rmse_NNs = zeros(length(range),repetitions);

for rep = 1:repetitions
    for i = 1:length(range)

        N = range(i);

        disp([rep i])
        
        [inertial,inds] = correction_features(inertial,ground_truth,inds,N);
        [rmse_ZUPT,rmse_GPs(i,rep),rmse_NNs(i,rep),rmse_static] = performance(inertial,ground_truth,inds);

    end
end

end

