function inds = temporal_alignment(inertial,ground_truth,dt)

% Temporal alignment of sampling instances.
inds = [];
for k = 1:length(inertial.t)
    [~,ind] = min(abs(inertial.t(k)-ground_truth.t+dt));
    inds = [inds ind];
end

end

