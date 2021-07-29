function euler = R2euler(R)

    % Compute Euler angles from rotation matrix.
    r = atan2(R(3,2),R(3,3));
    p = -asin(R(3,1));
    y = atan2(R(2,1),R(1,1));

    euler = [r p y];
    
end

