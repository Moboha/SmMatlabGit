function [VQ1new, VQ2new ]= estimateTwoWayConnection2( VQ1, V2,  vol1_train, q1_train, vol2_train, dampeningFactor)
%VQ1 is SS  vols and q's from 1 to 2. V2 is SS vols in 2. 
%vol1_train is vols in 1 during e.g. cds rain and q1_train is the
%corresponing flow from 1 to 2. vol2_train is corresponing volumes in 2.
%[VQ1new, VQ2] only have positive flows and these are optimised to training data
%with the constrain that the SS solution should still hold. Works for a
%single connection only. q_train, vol1_train and vol2_train are equally
%long vectors with the training data. 
%dampeningFactor default = 1. This means that the max change in volume due
%to the back water flow is 1/60 of the volume pr. second. 

%ensures dampning by setting volume dependent max. 

qbw0 = zeros(size(V2));

lb = zeros(size(qbw0));
%ub = ones(size(qbw0))*( max(abs(q1_train))+max(abs(VQ1(:,2))))*2 % Here is a potential for gaining speed. 
ub = max(V2, VQ1(:,1))/(60*dampeningFactor); % Here is a potential for gaining speed. 


ub(1) = 0;

VQ2 = [V2, zeros(size(V2))];
% %if SS q is negative then swap to the other mus.
for i=1:length(V2)
    if(VQ1(i,2)<0)
        VQ2(i,2) = VQ1(i,2);
        VQ1(i,2) = 0;       
    end
end

qbw= fmincon(@(params) objFuncForBWfunc(params,VQ1, VQ2,  vol1_train, q1_train, vol2_train),qbw0,[],[],[],[],lb, ub);%,[], options)
qbw
VQ1new = VQ1;
VQ1new(:,2) = VQ1new(:,2) + qbw;

VQ2new = VQ2;
VQ2new(:,2) = VQ2new(:,2) + qbw;

end

