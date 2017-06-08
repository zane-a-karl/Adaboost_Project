function [ Y ] = wl4( intIms, p )
% HORIZONTAL THIRDS

N = length(intIms(1,1,:));
s = length(intIms(:,1,1));
Y = zeros(1, N);

for i = 1 : N
    im = intIms(:,:,i);
    S_1 = im(p+1,s); % top third
    S_1 = S_1 + im(s,s) - im(s-p+1, s); % bottom third
    S_2 = im(s-p+1,s) - im(p+1,s); % middle third
    x = S_1 - S_2;
    Y(i) = x;
end


end

