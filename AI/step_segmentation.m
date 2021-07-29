function [inertial,ground_truth] = step_segmentation(inertial,ground_truth)

% Initializations.
zupt = inertial.zupt;
zupt_counter = 0;
no_zupt_counter = 0;
steps = [];
reached_no_zupt_counter = 0;

% Iterate over ZUPTs.
for k = 1:length(zupt)
    
    % Set ZUPTs counters.
    if(zupt(k)==1)
        zupt_counter = zupt_counter + 1;
        no_zupt_counter = 0;
    else
        no_zupt_counter = no_zupt_counter + 1;
        zupt_counter = 0;
    end
    
    % Step detection.
    if(zupt_counter==10)
        if(reached_no_zupt_counter)
            steps = [steps k-2];
            reached_no_zupt_counter = 0;
        end
    end
    if(no_zupt_counter==50)
        reached_no_zupt_counter = 1;
    end
    
end

% Save fields.
inertial.step_seg = steps;
inds = temporal_alignment(inertial,ground_truth,0);
ground_truth.step_seg = inds(inertial.step_seg);

end

