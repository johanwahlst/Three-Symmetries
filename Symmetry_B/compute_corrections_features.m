function [y_testing_GP,y_testing_NN,y_testing_static] = compute_corrections_features(x,y)

% Initialize predicted yaw.
y_testing_GP = zeros(size(y));
y_testing_NN = zeros(size(y));

% Set the number of division of testing/training data.
D = 10;

for i = 1:D
    
    % Set indices for training and testing.
    training_ind = [1:floor(size(x,3)*1/D*(i-1)) floor(size(x,3)*1/D*i+1):floor(size(x,3))];
    testing_ind = floor(size(x,3)*1/D*(i-1)+1):floor(size(x,3)*1/D*i);

    % Set training data.
    x_training = [];
    y_training = [];
    for l = 1:size(x,1)
        x_training = [x_training squeeze(x(l,:,training_ind))];
        y_training = [y_training y(:,training_ind)];
    end
    x_training = x_training';
    y_training = y_training';

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
    
    y_testing_GP_temp = zeros(length(testing_ind),size(x,1));
    y_testing_NN_temp = zeros(length(testing_ind),size(x,1));

    % Compute testing data.
     for l = 1:size(x,1)
        x_testing = squeeze(x(l,:,testing_ind))';
        y_testing_GP_temp(:,l) = predict(gprMdl,x_testing);
        y_testing_NN_temp(:,l) = net(x_testing');
    end
    
    y_testing_GP_temp = mean(y_testing_GP_temp,2);
    y_testing_NN_temp = mean(y_testing_NN_temp,2);

    % Save testing data.
    y_testing_GP(testing_ind) = y_testing_GP_temp;
    y_testing_NN(testing_ind) = y_testing_NN_temp;
    
end

% Fit static correction.
y_testing_static = mean(y)*ones(size(y));

end

