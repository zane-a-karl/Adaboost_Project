% Helper function to clean up code

function [ theta, p ] = mean_overlap_thresh_and_parities( K, Y_F, Y_NF, M )

overlap = zeros(M, K);
edges = zeros(M+1,K);
theta = zeros(1, K);

for k = 1 : K
    % display(size(nice_hists_compare(Y_F(:,k), Y_NF(:,k), M)));
    edges(:,k) = nice_hists_compare(Y_F(:,k), Y_NF(:,k), M);
    bins1 = histcounts(Y_F(:,k), edges(:,k));
    bins2 = histcounts(Y_NF(:,k), edges(:,k));
    % display(size(min(bins1, bins2)));
    overlap(:,k) = min(bins1, bins2);
end
[~, maxInd] = max(overlap);
for k = 1 : K
    theta(k) = edges(maxInd(k),k);
end

p = ones(1, K);

FMean = mean(Y_F);
NFMean = mean(Y_NF);

for j = 1 : K
    if FMean(j) >= NFMean(j)
        p(j) = -1;
    end
end

end