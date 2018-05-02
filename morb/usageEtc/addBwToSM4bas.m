


Muses = MusesWithSSdata;
CdsLinksVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_links.txt'];
CdsNodesVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_nodes.txt'];
CdsPrfAsCsv = [basefolder, '\frri\CDS_rains\CDS_5\output.csv'];%for backwater estimation a.o.

VolTS = ExtractMusVolumesFromNodesAndLinksVols(Muses, CdsNodesVolFile, CdsLinksVolFile);
qTS = extractMusOutflows(Muses, CdsPrfAsCsv);

i1 = getSmMusIndex(MusesWithSSdata, 'sm4bas')
i2 = getSmMusIndex(MusesWithSSdata, 'sm4')

VQ1 = [[0,0]', MusesWithSSdata(i1).consOut(1).VolQdata'];
plot(VQ1(1,:), VQ1(2,:))
V2 = [0, MusesWithSSdata(i2).consOut(1).VolQdata(:,1)']

iVol1 = getnameidx(VolTS.nameList, 'sm4bas')
iVol2 = getnameidx(VolTS.nameList, 'sm4')
iQ = getnameidx(qTS.nameList, '96_OGCBAS1l1')
clf; 
plot(VQ1(1,:), VQ1(2,:)), hold on, 
plot(VolTS.data(:,iVol1), qTS.data(:,iQ), '*r')
%title(Muses(i).name)

vol1_train = VolTS.data(:,iVol1);
q1_train = qTS.data(:,iQ);
vol2_train = VolTS.data(:,iVol2);

[VQ1new, VQ2 ]= estimateTwoWayConnection( VQ1', V2',  vol1_train, q1_train, vol2_train)


MusesWithSSdata(i1).consOut(1).VolQdata = VQ1new



MusesWithSSdata(i2).consOut(2) = musCon()
MusesWithSSdata(i2).consOut(2).VolQdata = VQ2
MusesWithSSdata(i2).consOut(2).VolQdata
MusesWithSSdata(i2).consOut(2).toMus = i1
MusesWithSSdata(i2).consOut(2).name = 'bwcon1'

% plotSingleLink(xx, tt,  FlowTS, '96_OGCBAS1l1')
