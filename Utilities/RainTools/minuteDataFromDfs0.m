function minuteData = minuteDataFromDfs0(filename, starttimeDateNum, endtimeDateNum)

%filename = 'H:\SyncPC\MBdata\Projekter\KlimaSpring\Data\Rainfall\MeanAreaRainfall_part1\CB_2_O18010Kl1.dfs0'

%starttimeDateNum=  datenum(2014,12,24,0,0,0);
%endtimeDateNum =  datenum(2014,12,24,7,0,0) ;



NET.addAssembly('DHI.Generic.MikeZero.DFS');
import DHI.Generic.MikeZero.DFS.*;
import DHI.Generic.MikeZero.DFS.dfs0.*;

dfs0  = DfsFileFactory.DfsGenericOpen(filename);
dd = double(Dfs0Util.ReadDfs0DataDouble(dfs0));


Nt = length(dd(:,1));


tx= dfs0.FileInfo.TimeAxis.StartDateTime;
tStartFile = datenum(double(tx.Year), double(tx.Month), double(tx.Day), double(tx.Hour), double(tx.Minute), double(tx.Second));
tEndFile = datenum(double(tx.Year), double(tx.Month), double(tx.Day), double(tx.Hour), double(tx.Minute), double(tx.Second));

ts1= timeseries(dd(:,2), dd(:,1));

tnStartInSec = (starttimeDateNum - tStartFile)*24*3600;
tnEndInSec = (endtimeDateNum - tStartFile)*24*3600;

ts2 = resample(ts1, [tnStartInSec:60:tnEndInSec],'zoh');

 
  
 minuteData= ts2.Data;
end
 