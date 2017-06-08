function [ predicted_labels, training_labels, theta, p ] = weak_learners( Y_P1, Y_N1, Y_P2, Y_N2, Y_P3, Y_N3, feature, M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

a = 2429;
b = 4548;
% f = reshape(faces, 19*19, a);
% nf = reshape(nonFaces, 19*19, b);
% training_ims = [f , nf];
% training_ims = reshape(training_ims, [19,19,a+b]);

t1 = ones(1,a);
t2 = ones(1,b);
t2 = t2*(-1);
training_labels = [t1,t2];

switch feature
    case 1
        [predicted_labels, theta, p] = mean_overlap_classify(Y_P1, Y_N1, M);
    case 2
        [predicted_labels, theta, p] = mean_overlap_classify(Y_P2, Y_N2, M);
    case 3
        [predicted_labels, theta, p] = mean_overlap_classify(Y_P3, Y_N3, M);
    otherwise
end
for i = 1 : length(predicted_labels(:,1))
    for j = 1 : length(predicted_labels(1,:))
        if predicted_labels(i,j) == 0
            predicted_labels(i,j) = -1;
        end
    end
end

end

