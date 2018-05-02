function Muses = addBwConToMUS(MusesWithSSdata, CdsVolTs, CdsQTs, linkName, dampening  )
%ADDBWCONTOMUS Summary of this function goes here
%   Detailed explanation goes here

[fromMus, toMus, iCon] = getConMusIndex( MusesWithSSdata, linkName );
fromName = MusesWithSSdata(fromMus).name
toName = MusesWithSSdata(toMus).name

i1 = getSmMusIndex(MusesWithSSdata, fromName);
i2 = getSmMusIndex(MusesWithSSdata, toName);

VQ1 = [[0,0]', MusesWithSSdata(i1).consOut(iCon).VolQdata'];
V2 = [0, MusesWithSSdata(i2).consOut(iCon).VolQdata(:,1)'];

iVol1 = getnameidx(CdsVolTs.nameList, fromName);
iVol2 = getnameidx(CdsVolTs.nameList, toName);
iQ = getnameidx(CdsQTs.nameList, linkName);
figure;
title(['bw plot ', linkName]);
plot(VQ1(1,:), VQ1(2,:)), hold on, 
plot(CdsVolTs.data(:,iVol1), CdsQTs.data(:,iQ), '*r')
%title(Muses(i).name)

vol1_train = CdsVolTs.data(:,iVol1);
q1_train = CdsQTs.data(:,iQ);
vol2_train = CdsVolTs.data(:,iVol2);

[VQ1new, VQ2 ]= estimateTwoWayConnection2( VQ1', V2',  vol1_train, q1_train, vol2_train,dampening)

MusesWithSSdata(i1).consOut(iCon).VolQdata = VQ1new(2:end,:);

MusesWithSSdata(i2).consOut(end+1) = musCon();
MusesWithSSdata(i2).consOut(end).VolQdata = VQ2(2:end,:);
MusesWithSSdata(i2).consOut(end).VolQdata;
MusesWithSSdata(i2).consOut(end).toMus = i1;
MusesWithSSdata(i2).consOut(end).name = [char(linkName), '(BW)'];

Muses = MusesWithSSdata;

end

