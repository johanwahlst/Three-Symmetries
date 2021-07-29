function pos_correction = corrections_postprocessing(y_yaw_correction,y_position_correction,inertial,inertial_euler,inds)

% Compute new yaw increments.
diff_yaw = diff(inertial_euler(3,:)) + y_yaw_correction;

% Compute new yaw estimates.
new_yaws = cumsum([inertial_euler(3,1) diff_yaw]);

% Wrap new yaw.
while(sum(new_yaws<-pi))
    new_yaws(new_yaws<-pi) = new_yaws(new_yaws<-pi) + 2*pi;
end
while(sum(new_yaws>pi))
    new_yaws(new_yaws>pi) = new_yaws(new_yaws>pi) - 2*pi;
end

% Initialize new position estimates.
pos_correction = zeros(3,length(inds));
pos_correction(:,1) = inertial.pos(:,inds(1));

% Iterate over steps.
for k = 2:length(inds)
     
    % Compute new position estimates.
    temp_euler = R2euler(inertial.R(:,:,inds(k-1)));
    corrected_euler = temp_euler;
    corrected_euler(3) = new_yaws(k-1);
    new_R = Rotation_matrix(corrected_euler);
    pos_correction(:,k) = new_R*(inertial.R(:,:,inds(k-1))'*(inertial.pos(:,inds(k))-inertial.pos(:,inds(k-1)))+y_position_correction(:,k-1))+pos_correction(:,k-1);

end   

end

