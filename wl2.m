function [ Y ] = wl2( intIms, p )
% VERTICAL SPLIT

N = length(intIms(1,1,:));
s = length(intIms(:,1,1));
Y = zeros(1, N);

for i = 1 : N
    im = intIms(:,:,i);
    S_1 = im(s,p);
    S_2 = im(s,s) - S_1;
    x = S_1 - S_2;
    Y(i) = x;
end


end

