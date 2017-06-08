%{
This function takes in a single feature and tests its ability to classify
all of the test images.
Input:
    - feat_ind
    - test_ims
    - m
    - feats1, feats2, feats3
    - theta, p, true_labels
Return:
    - acc
%}
function [ acc ] = one_feature_classify( feat_ind, test_ims, m, feats1, feats2, feats3, theta, p, true_labels )

    diffs = apply_best_feature(test_ims, feat_ind, m, feats1, feats2, feats3);
    labels = mean_overlap_classify_helper(diffs', theta, p);

    S = 0;
    display(length(true_labels));
    display(length(labels));
    for i = 1 : length(true_labels)
        if labels(i) == true_labels(i)
            S = S + 1;
        end
    end
    acc = S / length(true_labels);
end

