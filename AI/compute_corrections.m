function [y_testing_GP,y_testing_NN,y_testing_static] = compute_corrections(x,y)

% Initialize predicted yaw.
y_testing_GP = zeros(size(y));
y_testing_NN = zeros(size(y));

% Set the number of division of testing/training data.
D = 10;

for i = 1:D
    
    % Set indices for training and testing.
    training_ind = [1:floor(size(x,2)*1/D*(i-1)) floor(size(x,2)*1/D*i+1):floor(size(x,2))];
    testing_ind = floor(size(x,2)*1/D*(i-1)+1):floor(size(x,2)*1/D*i);

    % Set training data.
    x_training = x(:,training_ind)';
    y_training = y(:,training_ind)';

    % Fit GP.
    gprMdl = fitrgp(x_training,y_training,'Basisfunction','none');
  
    % Fit NN.
    net = feedforwardnet(2);
    rng('default');
    net.trainParam.showWindow = false;
    net.divideParam.trainRatio = 0.75;
    net.divideParam.valRatio   = 0.25;
    net.divideParam.testRatio  = 0;
    net = train(net,x_training',y_training');
    
    % Compute testing data.
    x_testing = x(:,testing_ind)';
    y_testing_GP_temp = predict(gprMdl,x_testing);
    y_testing_NN_temp = net(x_testing');
    
    % Save testing data.
    y_testing_GP(testing_ind) = y_testing_GP_temp;
    y_testing_NN(testing_ind) = y_testing_NN_temp;
    
end

% Fit static correction.
y_testing_static = mean(y)*ones(size(y));

end

