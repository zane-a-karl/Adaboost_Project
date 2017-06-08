function [ labels ] = mean_overlap_classify_helper( Y_test, theta, p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N = length(Y_test(:,1));
K = length(p);
labels = zeros(N, K);

for i = 1 : N
    for j = 1 : K
        if p(j)*Y_test(i,j) < p(j)*theta(j)
            labels(i,j) = 1;
        end
    end
end

end

