function [ diffs ] = apply_best_feature( Images, best_feature_ind, m, feats1, feats2, feats3 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    ii = integralImage(Images); % this is 20x20*length(images)
 
    %%%%% WARNING - DO NOT UNCOMMENT %%%%%
    N = length(ii(1,1,:));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % KEEP N SMALL <= 200
    %N = 500;
    s = length(ii(:,1,1)); % this is always 20 for faces
    diffs = zeros(1,N);
 
    switch m
        case 1
            best_feature = feats1(:,best_feature_ind);
            w = best_feature(1);
            h = best_feature(2);
            p = best_feature(3);
            for i = 1 : N
                x_1 = s - floor((20-w)/2); % doesn't change
                y_1 = p + floor(h/2);
                x_2 = floor((20-w)/2) + 1; % doesn't change
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

                diffs(i) = S_1 - S_2;
            end
        case 2
            best_feature = feats2(:,best_feature_ind);
            px = best_feature(1);
            py = best_feature(2);
            w = best_feature(3);
            h = best_feature(4);
            t = best_feature(5);
            for i = 1 : N
                x1 = px + t; y1 = py + h;
                x2 = px; y2 = y1;
                x3 = x1; y3 = py;
                x4 = px; y4 = py;

                D = ii(x1,y1,i) - ii(x2,y2,i) - ii(x3,y3,i) + ii(x4,y4,i);

                x1_ = px + w; y1_ = y1;
                x2_ = px + w - t; y2_ = y2;
                x3_ = x1_; y3_ = y3;
                x4_ = x2_; y4_ = y4;

                % this is the final sum of the Dark section
                D = D + (ii(x1_,y1_,i) - ii(x2_,y2_,i) - ii(x3_,y3_,i) + ii(x4_,y4_,i));

                a1 = x2_; b1 = y2_;
                a2 = x1; b2 = y1;
                a3 = x4_; b3 = y4_;
                a4 = x3; b4 = y3;

                % this is the final sum of the Light section
                L = ii(a1,b1,i) - ii(a2,b2,i) - ii(a3,b3,i) + ii(a4,b4,i);
                diffs(i) = D - L;
            end
        case 3
            best_feature = feats3(:,best_feature_ind);
            px = best_feature(1);
            py = best_feature(2);
            tx = best_feature(3);
            ty = best_feature(4);
            for i = 1 : N
                x1 = px + tx; y1 = py + ty;
                x2 = px; y2 = y1;
                x3 = x1; y3 = py;
                x4 = x2; y4 = y3;

                A_1 = ii(x1,y1,i) - ii(x2,y2,i) - ii(x3,y3,i) + ii(x4,y4,i);

                a1 = px + 2*tx; b1 = py + 2*ty;
                a2 = x1; b2 = b1;
                a3 = a1; b3 = y1;
                a4 = x1; b4 = y1;

                B_1 = ii(a1,b1,i) - ii(a2,b2,i) - ii(a3,b3,i) + ii(a4,b4,i);

                S_1 = A_1 + B_1;

                c1 = a2; d1 = b2; 
                c2 = x2; d2 = d1; 
                c3 = x1; d3 = y1;
                c4 = x2; d4 = y2;

                A_2 = ii(c1,d1,i) - ii(c2,d2,i) - ii(c3,d3,i) + ii(c4,d4,i);

                e1 = a3; f1 = b3;
                e2 = x1; f2 = y1;
                e3 = a3; f3 = y3;
                e4 = x3; f4 = y3;

                B_2 = ii(e1,f1,i) - ii(e2,f2,i) - ii(e3,f3,i) + ii(e4,f4,i);

                S_2 = A_2 + B_2;

                diffs(i) = S_1 - S_2;
            end
        otherwise
    end
end

