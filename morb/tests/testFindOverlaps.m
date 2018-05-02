function testFindOverlaps()
%TESTFINDOVERLAPS Summary of this function goes here
%   Detailed explanation goes here

musFileFolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\musfiles1';    % it is only for reading the files, isn'it?
mexFile = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\NW_CDSBase.mex';

Muses = extractMusInforFromFolder(musFileFolder)
checkMusForOverlaps(Muses);


disp('*****************************')
musFileFolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\musfiles2';    % it is only for reading the files, isn'it?
Muses2 = extractMusInforFromFolder(musFileFolder)
checkMusForOverlaps(Muses2);



disp('*****************************')
musFileFolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\testData\musfiles1to7';    % it is only for reading the files, isn'it?
Muses3 = extractMusInforFromFolder(musFileFolder)
checkMusForOverlaps(Muses3);

end

