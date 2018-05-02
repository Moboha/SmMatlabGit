basefolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Utilities\RainTools\testData';
eventFolder = [basefolder, '\eventxx']

folderWithDfs0RainFiles = 'H:\SyncPC\MBdata\Projekter\KlimaSpring\Data\Rainfall\MeanAreaRainfall_part1'

startDate = datenum(2014,12,24,4,0,0);
endDate = datenum(2014,12,24,7,0,0);

makeEventFolder(eventFolder, folderWithDfs0RainFiles, startDate, endDate);