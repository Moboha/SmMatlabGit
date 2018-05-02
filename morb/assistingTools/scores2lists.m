function [NSE, NSE30, relSumErr, lags, absSumErr] =   scores2lists( scores )


N= length(scores);
NSE = zeros(N,1);
NSE30 = zeros(N,1);
relSumErr = zeros(N,1);
absSumErr = zeros(N,1);
lags = zeros(N,1);

for i=1:N
    
    NSE(i) = scores(i).NSE;   
     NSE30(i) = scores(i).NSE30min; 
    relSumErr(i) = scores(i).relSumErr;
    absSumErr(i) = scores(i).absSumErr;
    lags(i) = scores(i).lag;
end


end

