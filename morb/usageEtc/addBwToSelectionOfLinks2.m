function Muses = addBwToSelectionOfLinks2(Muses, CdsLinksVolFile, CdsNodesVolFile, CdsPrfAsCsv, listOfLinksWithBW, dampening)

CdsVolTs = ExtractMusVolumesFromNodesAndLinksVols2(Muses, CdsNodesVolFile, CdsLinksVolFile);
CdsQTs = extractMusOutflows(Muses, CdsPrfAsCsv);

for i=1:length(listOfLinksWithBW)
    linkName = listOfLinksWithBW(i);
    Muses = addBwConToMUS(Muses, CdsVolTs, CdsQTs, linkName, dampening);
end


end
