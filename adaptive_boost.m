

function [strong_learner] = adaptive_boost(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, M) 
 
    % Total count of images 	
    [C, ~] = size(vertcat(Y_P1, Y_N1));

    % Initialize weights
    current_weights = ones(1, C) / C; %starting weights are uniformly distributed
    
    
%     alpha_save = zeros(1,3);
%     best_feature_vectors = zeros(C,3);
%     best_features = zeros(1,3);
%     thresholds = zeros(1,3);
%     parities = zeros(1,3);

    % Limit for convergence of error function
    %delta = 0.1; 

    %%%% This is the major change, I?m gonna run every class of learner (basically every possible
    %%%% feature ever) and then combine all the results into single matrixes so each of them can
    %%%% compared together. There was no reason for us to be only checking one type at a time.
    %%%% Effectively, we compute all feature values at once and just use the results as below.

    [weaklearner1_output, labels1, theta1, p1] = weak_learners(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, 1, M); 
    [weaklearner2_output, ~, theta2, p2] = weak_learners(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, 2, M); 
    [weaklearner3_output, ~, theta3, p3] = weak_learners(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, 3, M); 

    %%%% Here, I combine outputs of each learner into unified sets to be compared in totality

    weaklearners_output = horzcat(weaklearner1_output, weaklearner2_output, weaklearner3_output);
    theta = horzcat(theta1, theta2, theta3);
    p = horzcat(p1, p2, p3);

    % feat count is total number of possible features 
    [~, feature_count] = size(weaklearners_output);

    % Create total labels matrix
    total_labels = repmat(labels1', 1, feature_count);

    % Calculate indicator function (1 for misclassified, 0 if not)
    indicator_function = (weaklearners_output ~= total_labels);

    % Just gonna limit T till 200, doubt we reach there
    T = 1;
    while (T < 20) 

        % Error function
        error_function = current_weights * indicator_function;

        % Find best feature with minimum error
        [epsilon , best_feature] = min(error_function);

        % Break cases for epsilon
        if (epsilon == 0 || epsilon >= 0.5)
            break;
        end

        % Update epsilon (error of best feature) but also check for
        % convergence - if it changes less than delta, we break
%        last_epsilon = epsilon;
        epsilon = epsilon / (sum(current_weights));
%         current_delta = (last_epsilon - epsilon)/last_epsilon;
%         if (abs(current_delta) < delta)
%             break;
%         end

        % Store best features index, parameters
        best_features(T) = best_feature;
        thresholds(T) = theta(best_feature);
        parities(T) = p(best_feature);

        % Calculate and save alpha - a measure of strength of current learner
        alpha = log((1 - epsilon)/epsilon);
        alpha_save(T) = alpha;

        % Update weights for next iteration
        for i = 1 : C
            current_weights(i) = current_weights(i)*exp(alpha*indicator_function(i, best_feature));
        end

    end

    % returns the best alphas and best feature indices, stored in a 4x3 matrix
    strong_learner = [alpha_save; best_features; thresholds; parities];

end




































% function [strong_learner] = adaptive_boost(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, M) 
% 
%     % total number of training images - positives and negatives
%     [C, ~] = size(vertcat(Y_P1, Y_N1)); 
%     % C = 6977;
%    
%     current_weights = ones(1, C) / C; % starting weights are uniformly distributed
%     alpha_save = zeros(1,3);
%     best_feature_vectors = zeros(C,3);
%     best_features = zeros(1,3);
%     thresholds = zeros(1,3);
%     parities = zeros(1,3);
%     
%     
%     % we are looping through the three possible feature sets
%     for T = 1:3 
%         % current_learner_output is 1 or -1 depending on 
%         % this feat set's classification and labels is 1 or -1 depending on
%         % what an img actually is (training label) 
%         switch T
%             case 1
%                 [current_learner_output, labels, theta, p] = weak_learners(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, T, M); 
%             case 2
%                 [current_learner_output, labels, theta, p] = weak_learners(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, T, M); 
%             case 3
%                 [current_learner_output, labels, theta, p] = weak_learners(Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, T, M); 
%             otherwise
%         end
%         display(size(current_learner_output));
% 
%         % feature_count is total num feats for given feat set
%         [~, feature_count] = size(current_learner_output);
%         total_labels = repmat(labels', 1, feature_count);
%         
%         % Indicator function: (1 if image is misclassified, 0 if not) 
%         indicator_function = (current_learner_output ~= total_labels);
%         
%         % display(size(current_weights));
%         % display(size(indicator_function));
%         
%         % Error function: Weighted sum of indicator function - to minimize
%         error_function = current_weights * indicator_function;
%         
%         [epsilon , best_feature] = min(error_function);
%         best_features(T) = best_feature;
%         thresholds(T) = theta(best_feature);
%         parities(T) = p(best_feature);
%         
%         % Update epsilon, save alpha for current feature class
%         epsilon = epsilon / (sum(current_weights));
%         alpha = log((1 - epsilon)/epsilon);
%         alpha_save(T) = alpha;
%        
%         % Save the feature parameters of the chosen best feature
%         best_feature_vectors(:,T) = current_learner_output(:, best_feature);
%         
%         % Update weights, weighting misclassified data points heavier for
%         % next iteration - choosing best feature of next feature class
%         for i = 1 : C
%             current_weights(i) = current_weights(i)*exp(alpha*indicator_function(i, best_feature));
%         end
%     end
%     
%     % Returns alphas, paramaters, threshhold feature values and parities of
%     % chosen best features/weak learners, in a 4x3 matrix.
%     % We use these to finally construct the strong learner.
%     strong_learner = [alpha_save; best_features; thresholds; parities];
% 
% end
%     
%     