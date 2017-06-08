% For each feature, this function returns classifaction labels by computing
% a decision boundary based on the mean of the overlap from our training
% data.

function [ labels, theta, p ] = mean_overlap_classify( Y_P, Y_N, M )

% N = length(Y_P(:,1)) + length(Y_N(:,1)); % N = # of training images
K = length(Y_P(1,:)); % K = # of features for given feature set

% labels = zeros(N,K);

[theta, p] = mean_overlap_thresh_and_parities(K, Y_P, Y_N, M);
to_classify = [Y_P ; Y_N];
[labels] = mean_overlap_classify_helper(to_classify, theta, p);

% switch feature
%     case 1
%         [theta, p] = mean_overlap_thresh_and_parities(K, Y_P, Y_N, M);
%         % [to_classify, ~] = feature_set1(test_data);
%         to_classify = [Y_P ; Y_N];
%         [labels] = mean_overlap_classify_helper(to_classify, theta, p);
%     case 2
%         [theta, p] = mean_overlap_thresh_and_parities(K, Y_P, Y_N, M);
%         [to_classify, ~] = feature_set2(test_data);
%         [labels] = mean_overlap_classify_helper(to_classify, theta, p);
%     case 3
%         [theta, p] = mean_overlap_thresh_and_parities(K, Y_P, Y_N, M);
%         [to_classify, ~] = feature_set3(test_data);
%         [labels] = mean_overlap_classify_helper(to_classify, theta, p);
%     otherwise
% end


end

