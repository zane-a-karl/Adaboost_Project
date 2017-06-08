%{
This function generates all possible centered, vertically cut in thirds. 
Input:
    - The array of images -> [w x h x (num imgs)]
Return:
    - matrix of images feature differences for a given feature [num imgs x
      num features]
%}

function [Y, feat] = generalized_feature_set2(Imgs)
    ii = integralImage(Imgs);

    N = length(ii(1,1,:));
    s1 = length(ii(:,1,1)); %width
    s2 = length(ii(1,:,1)); %height
    
    c = 0;
    for px = 1:s1 - 6 % loops through possible pxs
        for py = 1:s2-1 % loops through possible pys
            for w = 6:s1-px % loops through possible widths
                for h = 1:s2 - py % loops through possible heights
                    for t = 2:floor(w/2)-1 % possible thicknesses
                        c = c + 1;
                     end
                end
            end
        end
    end 
  
    Y = zeros(N, c);
    feat = zeros(5, c);
    
    for i = 1:N % loops through the imgs
        c = 0;
        for px = 1:s1 - 6 % loops through possible pxs
            for py = 1:s2-1 % loops through possible pys
                for w = 6:s1-px % loops through possible widths
                    for h = 1:s2 - py % loops through possible heights
                        for t = 2:floor(w/2)-1 % possible thicknesses
                            c = c + 1;

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
                            Y(i,c) = D - L;

                            if i ==1
                                feat(1,c) = px;  % save position
                                feat(2,c) = py;  
                                feat(3,c) = w;  % save width
                                feat(4,c) = h;  % save height
                                feat(5,c) = t;  % save thickness
                            end
                        end
                    end
                end
            end
        end 
    end
end
