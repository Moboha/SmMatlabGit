function plotBwQsBothWays( MusesNoBw, MusesWithBW, linkName )
%PLOTBWQSBOTHWAYS Summary of this function goes here
%   Detailed explanation goes here

figure
Muses = MusesNoBw;

[fromMus, toMus, iCon] = getConMusIndex(Muses, linkName);
vqSS = Muses(fromMus).consOut(iCon).VolQdata;

Muses = MusesWithBW;
[fromMus, toMus, iCon] = getConMusIndex(Muses, linkName);
vq1 = Muses(fromMus).consOut(iCon).VolQdata;

[fromMus, toMus, iCon] = getConMusIndex(Muses,[linkName, '(BW)']);
vq2 = Muses(fromMus).consOut(iCon).VolQdata;


plot(vqSS(:,2),'-*g')
hold on
plot(vq1(:,2),'*b')

plot(vq2(:,2),'*r')


end

