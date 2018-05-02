function [relSumErr, AbsSumErr] = relDifInSums( x1, x2)
%difference compared to x1
sum1 = sum(x1);
sum2=sum(x2);
AbsSumErr = sum2 - sum1;
relSumErr = AbsSumErr/sum1;

end

