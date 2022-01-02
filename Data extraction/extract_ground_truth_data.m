function ground_truth = extract_ground_truth_data(num)

filename = strcat(num2str(num),'_Synchronized_Reference.csv');

% Read data.
b = csvread(filename,0,0);

% Scale factor.
s = 0.001;

% Extract data.
ground_truth.t = b(:,1)'/1000;
ground_truth.pos = s*b(:,3:5)';
ground_truth.R = zeros(3,3,size(b,1));
for k = 1:size(b,1)
    ground_truth.R(:,:,k) = vec2mat(b(k,6:14),3);
end

% Remove faulty data.
inds = find(sum(ground_truth.pos.^2,1)~=0 & squeeze(sum(sum(ground_truth.R.^2,1),2))'~=0);
ground_truth.t = ground_truth.t(inds);
ground_truth.pos = ground_truth.pos(:,inds);
ground_truth.R = ground_truth.R(:,:,inds);

end

