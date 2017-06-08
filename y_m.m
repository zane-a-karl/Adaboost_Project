function [ labels ] = y_m( weak_learner, m, Images, feats1, feats2, feats3 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

index = weak_learner(2);
theta = weak_learner(3);
p = weak_learner(4);

N = length(Images(1,1,:));

diffs = apply_best_feature(Images, index, m, feats1, feats2, feats3);

labels = zeros(1,N);

for i = 1 : N
    if p*diffs(i) < p*theta
        labels(i) = 1;
    else
        labels(i) = -1;
    end
end

end

