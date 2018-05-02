function lagInMin = myDisplacement( x1, x2)
%

if(length(x1) ~= length(x2))
    error('vectors need to be of same length')
end

[acor,lag] = xcorr(x2, x1,30);%looks up to 30 minutes lag
[~,I] = max(abs(acor));
lagInMin = lag(I);


end

