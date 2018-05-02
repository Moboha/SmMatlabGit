function success = testReadDataFromDfsTxtFile( )
filename = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\Rain and csos\kloev2006to2010.txt';
tic
TS = readDataFromDfsTxtFile(filename); %
toc

%************************
clear all
filename = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\Rain and csos\kloev2006to2010.txt';
tic
TS = readDataFromDfsTxtFile(filename); %
toc

%10-08- 2006 00:00 (there are some hours of dry period at the beginning)
%24-08-2006 00:00 
rain200608110000to200608240000 = makeOneMinutesTS(TS,datenum(2006,8,10,0,0,0),datenum(2006,8,24,0,0,0));

plot(rain200608110000to200608240000.time, rain200608110000to200608240000.data)




end

