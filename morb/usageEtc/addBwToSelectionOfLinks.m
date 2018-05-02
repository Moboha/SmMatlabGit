

CdsLinksVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_links.txt'];
CdsNodesVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_nodes.txt'];
CdsPrfAsCsv = [basefolder, '\frri\CDS_rains\CDS_5\output.csv'];%for backwater estimation a.o.

CdsVolTs = ExtractMusVolumesFromNodesAndLinksVols(Muses, CdsNodesVolFile, CdsLinksVolFile);
CdsQTs = extractMusOutflows(Muses, CdsPrfAsCsv);

listOfLinksWithBW = {'93_358017l2';'93_356001l1';};
        

for i=1:length(listOfLinksWithBW)
linkName = listOfLinksWithBW(i);
Muses = addBwConToMUS(Muses, CdsVolTs, CdsQTs, linkName);
end



