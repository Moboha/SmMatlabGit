function SSE = objFuncForBWfunc(params, VQ1, VQ2,  vol1_train, q1_train, vol2_train)
%OBJFUNCFORBWFUNC Summary of this function goes here
%   Detailed explanation goes here



VQ1temp = VQ1;
VQ2temp = VQ2;



VQ1temp(:,2) = VQ1temp(:,2) + params;
VQ2temp(:,2) = VQ2temp(:,2) + params;

pw1 = PiecewiseLinearInterpolater(VQ1temp');
pw2 = PiecewiseLinearInterpolater(VQ2temp');

SSE = 0;

for i=1:length(vol1_train)
    %errs(i) = q1_train(i) - (pw1.calcValue(vol1_train(i)) -  pw2.calcValue(vol2_train(i)));
    SSE = SSE + (q1_train(i) - (pw1.calcValue(vol1_train(i)) -  pw2.calcValue(vol2_train(i))))^2;
end

%SSE


end

