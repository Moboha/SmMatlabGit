%SS estimation has to be run first to get Muses info 

Muses = MusesWithSSdata;

CdsLinksVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_links.txt'];
CdsNodesVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_nodes.txt'];
CdsPrfAsCsv = [basefolder, '\frri\CDS_rains\CDS_5\output.csv'];%for backwater estimation a.o.



MusWithBW = estimateAndAddBWconnectionToPrm( MusesWithSSdata,  musFileFolder, CdsNodesVolFile, CdsLinksVolFile, CdsPrfAsCsv )
