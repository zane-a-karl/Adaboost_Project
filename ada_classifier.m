function [ ada_labels ] = ada_classifier( Images, strong_learner, feats1, feats2, feats3 )

% ada_classifier: This is the final strong learner for classification, as learned by Adaptive Boosting. 

% Weighted linear combination of weak learners that were chosen by Adaboost
% for each class of image features.

M = length(strong_learner(1,:));

Y_M = zeros(1, length(Images(1,1,:)));
for m = 1 : M
    Y_M = Y_M + strong_learner(1,m) * y_m(strong_learner(:,m), m, Images, feats1, feats2, feats3);
end

ada_labels = sign(Y_M);


end

