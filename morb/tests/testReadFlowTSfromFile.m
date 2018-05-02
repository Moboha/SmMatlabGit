clear all
clf

prfAsCsv = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\fullPrfResults.csv';
listOfLinks = {'96_OGB0401l1', '96_OGC1200l1','96_OGACYCAp1'};

FlowTs = readFlowTSfromFile(prfAsCsv, listOfLinks),
figure;
i = 3;
plot(FlowTs.time, FlowTs.data(:,i))
title(listOfLinks{i});