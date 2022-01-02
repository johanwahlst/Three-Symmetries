function inertial = extract_inertial_data(num)

filename = strcat(num2str(num),'_IMURaw.csv');

% Read data.
a = csvread(filename,1,0);

% Extract inertial data.
inertial.u = [a(:,4:6)'; a(:,7:9)']; 

% Extract timestamps.
inertial.t = a(:,3)';
    
end

