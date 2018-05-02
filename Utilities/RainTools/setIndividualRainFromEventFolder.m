basefolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Utilities\RainTools\testData';
eventFolder = [basefolder, '\eventxx']

files = dir(eventFolder);


for i=3:length(files)
    file = files(i)
   load([eventFolder,'\',file.name]);%load minuteData
    [pathstr,name,ext] = fileparts(file.name);
   % model.setIndividualRainData(name,minuteData);

end