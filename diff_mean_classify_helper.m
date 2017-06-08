% Helper function to clean up code

function [ labels ] = diff_mean_classify_helper( N, M, mean_diff_labels, to_classify, avg )

    labels = zeros(N, M);
    for i = 1 : N
        for j = 1 : M
            if mean_diff_labels(j) == 1
                if (to_classify(i,j) > avg(j))
                    labels(i,j) = 1;
                end
            else
                if (to_classify(i,j) <= avg(j))
                    labels(i,j) = 1;
                end
            end
        end
    end

end

