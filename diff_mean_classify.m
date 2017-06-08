%{
Classifies the images
Input:
    - 'Images' to be classified
    - differences 'Y_F' corresponding to faces trained on 
    - differences 'Y_NF' corresponding to nonfaces trained on
    - 'feature' used to classify (this is an int = {1,2,3,4});
Output:
    - an array of 'labels' detailing whether the img in quesiton is a face
    or a non face.
%}
function [ labels ] = diff_mean_classify( Images, Y_F, Y_NF, feature )

    FMean = mean(Y_F);
    NFMean = mean(Y_NF);
    
    % val_f = mean(FMean); val_nf = mean(NFMean);
    
    M = length(FMean);
    mean_diff_labels = zeros(1, M);
    for i = 1 : M
        if FMean(i) > NFMean(i)
            mean_diff_labels(i) = 1;
        end
    end
    
    avg = (FMean + NFMean)/2;
    
    N = length(Images(1,1,:));
    switch feature
        case 1
            [to_classify, ~] = feature_set1(Images);
            labels = diff_mean_classify_helper(N, M, mean_diff_labels, to_classify, avg);
        case 2
            [to_classify, ~] = feature_set2(Images);
            labels = diff_mean_classify_helper(N, M, mean_diff_labels, to_classify, avg);
        case 3
            [to_classify, ~] = feature_set3(Images);
            labels = diff_mean_classify_helper(N, M, mean_diff_labels, to_classify, avg);
        otherwise
    end
end

