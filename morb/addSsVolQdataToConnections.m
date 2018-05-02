function MusesWithData = addSsVolQdataToConnections(MusesWithCatchments, VolTS, qTS, samplingIndex)

Muses = MusesWithCatchments;

Npoints = length(samplingIndex);
flowIndex = 1;
for i=1:length(Muses)
    
    for j=1:length(Muses(i).consOut)
        
        if (~isempty(Muses(i).consOut(j).toMus))%not an outlet
            toindex = Muses(i).consOut(j).toMus;
        end
        
        Muses(i).consOut(j).VolQdata = zeros(Npoints, 2);
        for k=1:length(samplingIndex)
            Muses(i).consOut(j).VolQdata(k,2) = qTS.data(samplingIndex(k),flowIndex);
            Muses(i).consOut(j).VolQdata(k,1) = VolTS.data(samplingIndex(k),i);
            
        end
        flowIndex = flowIndex + 1;
        
    end
    
end


MusesWithData = Muses;



end