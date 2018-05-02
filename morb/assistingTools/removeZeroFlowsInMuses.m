function MusesNoZero = removeNegativeFlowsInMuses( Muses )
%REMOVEZEROFLOWSINMUSES Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(Muses)
    
    for j=1:length(Muses(i).consOut)
        Qs = Muses(i).consOut(j).VolQdata(:,2);
        Qs(Qs<0) = 0;
        Muses(i).consOut(j).VolQdata(:,2)= Qs;       
    end

end

MusesNoZero = Muses;

end

