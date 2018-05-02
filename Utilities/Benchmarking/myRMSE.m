function rmse = myRMSE( x1, x2)
%

if(length(x1) ~= length(x2))
    error('vectors need to be of same length')
end

rmse = sqrt((sum((x1(:)-x2(:)).^2))/length(x1));

end

