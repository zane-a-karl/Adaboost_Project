function [ Y ] = wl3( intIms, p )
% VERTICAL THIRDS

N = length(intIms(1,1,:));
s = length(intIms(:,1,1));
Y = zeros(1, N);

for i = 1 : N
    im = intIms(:,:,i);
    S_1 = im(s,p); % left third
    S_1 = S_1 + im(s,s) - im(s, s-p); % right third
    S_2 = im(s,s-p) - im(s,p); % middle third
    x = S_1 - S_2;
    Y(i) = x;
end


end

