function makeEventFolder( eventFolder, folderWithDfs0RainFiles,startDate, endDate)

mkdir(eventFolder);
files = dir(folderWithDfs0RainFiles);

fiveMinutes = 5/(24*60);%used to compensate for the way the Aarhus dfs0 files have been created. In these the time stamp is in the end of each five minute interval, while minuteDataFromDfs0 assumes it is in the beginning. 

for i=3:length(files)
    file = files(i)
    minuteData = minuteDataFromDfs0([folderWithDfs0RainFiles,'\',file.name],startDate+fiveMinutes, endDate+fiveMinutes);
    minuteData = minuteData/60; %converts from mm/h to mm/minute
    [pathstr,name,ext] = fileparts(file.name)
    saveName = [eventFolder,'\',name,'.mat']
    save(saveName, 'minuteData') 

end
end
