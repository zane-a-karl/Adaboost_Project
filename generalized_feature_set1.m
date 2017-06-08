%{
This function generates all possible centered horizontally cut-in-half week
learners and saves them into a large matrix (Horizontal split)
Input:
    - The array of images
Return:
    - matrix of images by differences given weak learner
%}
 
function [ Y, feat ] = generalized_feature_set1( Images )
 
    ii = integralImage(Images); 
 
    %%%%% WARNING - DO NOT UNCOMMENT %%%%%
    N = length(ii(1,1,:));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % First, calculate number of features for array initialization
    s2 = length(ii(1,:,1)); % height of image
    s1 = length(ii(:,1,1)); % width of image
    
    c = 0;
    for w = 2 : s1
        for h = 2 : s2
            for p = 2 : s2 - h
                c = c + 1;
            end
        end
    end

    % Initialize output array
    Y = zeros(N, c);
    feat = zeros(3, c);
 
    for i = 1 : N % leaving this at 10 for now because the cpu will explode
        c = 0;
        for w = 2 : s1
            for h = 2 : s2
                for p = 2 : s2 - h
                    c = c + 1;
                    x_1 = s1 - floor((s1-w)/2); % doesn't change
                    y_1 = p + floor(h/2);
                    x_2 = floor((s1-w)/2) + 1; % doesn't change
                    y_2 = y_1;
                    x_3 = x_1; % doesn't change
                    y_3 = p;
                    x_4 = x_2; % doesn't change
                    y_4 = y_3;
 
                    S_1 = ii(x_1,y_1,i) - ii(x_2,y_2,i) - ii(x_3,y_3,i) + ii(x_4,y_4,i);
 
                    y_1 = y_1 + floor(h/2);
                    y_2 = y_2 + floor(h/2);
                    y_3 = y_3 + floor(h/2);
                    y_4 = y_4 + floor(h/2);
 
                    S_2 = ii(x_1,y_1,i) - ii(x_2,y_2,i) - ii(x_3,y_3,i) + ii(x_4,y_4,i);
 
                    diff = S_1 - S_2;
                    Y(i,c) = diff;
                    % This code saves the feature parameters
                    feat(1,c) = w;
                    feat(2,c) = h;
                    feat(3,c) = p;
                end
            end
        end
    end
end
