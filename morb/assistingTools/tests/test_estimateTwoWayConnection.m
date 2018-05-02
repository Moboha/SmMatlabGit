function test_estimateTwoWayConnection( )
%TEST_ESTIMATETWOWAYCONNECTION Summary of this function goes here
%   Detailed explanation goes here

%create some data
%clear all

VQ1_actual = [0 0; 1 1; 2 2; 3 3];
V2 = [0; 1; 2; 3];
Qbw = [0; 1; 1.7; 3];

VQ2_actual = zeros(size(VQ1_actual));
VQ2_actual(:,1) = V2;
VQ2_actual(:,2) = Qbw;

VQ1 = VQ1_actual; %observed SS VQ
VQ1(:,2) = VQ1(:,2) - Qbw;




%generates training data
pw1 = PiecewiseLinearInterpolater(VQ1_actual');
pw2 = PiecewiseLinearInterpolater(VQ2_actual');
vol1_train = rand(1000,1)*3;
vol2_train = rand(1000,1)*3;

for i=1:length(vol1_train)
    q1_train(i) =  pw1.calcValue(vol1_train(i)) -  pw2.calcValue(vol2_train(i));
end

%plot(q1_train)


[VQ1new, VQ2 ]= estimateTwoWayConnection( VQ1, V2,  vol1_train, q1_train, vol2_train)
% qbw =zeros(size(Qbw));
% lb = zeros(size(qbw));
% ub = ones(size(qbw))*10;
% ub(1) = 0;
%x= fmincon(@(params) objFuncForBWfunc(params,VQ1, V2,  vol1_train, q1_train, vol2_train),qbw,[],[],[],[],lb, ub);%,[], options)

assert( sum(abs(VQ1new(:)-VQ1_actual(:))) < 0.01)
assert( sum(abs(VQ2(:)-VQ2_actual(:))) < 0.01)



end

