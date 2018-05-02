function plotAllOutletsFromCompartments(xx, tt, FlowTS, MusesWithCons, compName)

iComp = getSmMusIndex(MusesWithCons, compName);

listOfLinks = {};
for i=1:length(MusesWithCons(iComp).consOut)
    %listOfLinks{end+1} = MusesWithCons(iComp).consOut(i).name;
    plotSingleLink( xx, tt, FlowTS, MusesWithCons(iComp).consOut(i).name)
    
end
title(['Outlets from ', compName]);
