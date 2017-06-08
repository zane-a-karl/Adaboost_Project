%{
This function generates all possible 4-square checkerboard features
features.
Input:
    - The array of images
Return:
    - matrix of images by differences given weak learner
%}
 
function [ Y, feat ] = feature_set3( Images )
 
    ii = integralImage(Images); % this is 20x20*length(images)
 
    N = length(ii(1,1,:));
    %N = 500;
    s = length(ii(:,1,1)); % this is always 20 for faces
    
    c = 0;
    for px = 1 : s - 2
        for py = 1 : s - 2
            for tx = 1 : floor((s - px)/2)
                for ty = 1 : floor((s - py)/2)
                    c = c + 1;
                end
            end
        end
    end
    
    Y = zeros(N, c);
    feat = zeros(4, c);
 
    for i = 1 : N
        c = 0;
        for px = 1 : s - 2
            for py = 1 : s - 2
                for tx = 1 : floor((s - px)/2)
                    for ty = 1 : floor((s - py)/2)
                        c = c + 1;
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

                        diff = S_1 - S_2;
                        Y(i,c) = diff;
                        % This code saves the feature parameters
                        if i == 1
                            feat(1,c) = px;
                            feat(2,c) = py;
                            feat(3,c) = tx;
                            feat(4,c) = ty;
                        end
                    end
                end
            end
        end
    end
end