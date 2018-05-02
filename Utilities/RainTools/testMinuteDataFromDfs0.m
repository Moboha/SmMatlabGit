


filename = 'H:\SyncPC\MBdata\Projekter\KlimaSpring\Data\Rainfall\MeanAreaRainfall_part1\CB_2_O18010Kl1.dfs0'

minuteData = minuteDataFromDfs0(filename, datenum(2014,12,24,4,0,0), datenum(2014,12,24,7,0,0) )
figure; plot(minuteData)
%Open the dfs0 file in MIKE and check manually that the minutedata looks
%like the dfs0 data. 