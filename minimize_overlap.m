function [ A, I ] = minimize_overlap( Y_F, Y_NF )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

M = 100;
K = length(Y_F(1,:));
mins = zeros(M, K);
for i = 1 : K
    edges = nice_hists_compare(Y_F(:,i), Y_NF(:,i), M);
    bins1 = histcounts(Y_F(:,i), edges);
    bins2 = histcounts(Y_NF(:,i), edges);
    mins(:,i) = min(bins1, bins2);
end

S = sum(mins);
[A, I] = sort(S, 'ascend');

end

