function plotQVolFromMuses( Muses, linkName )
%PLOTQVOLFROMMUSES Summary of this function goes here
%   Detailed explanation goes here
[fromMus, toMus, iCon] = getConMusIndex(Muses, linkName);
vq = Muses(fromMus).consOut(iCon).VolQdata;
plot(vq(:,1), vq(:,2),'*')



end

