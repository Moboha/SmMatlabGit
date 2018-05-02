



mexFile = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\NW_CDSBase.mex';
musFileFolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\musfiles1';

Muses = extractMusInforFromFolder(musFileFolder);
MusesWithCatchments = getConnectedCatchments(Muses, mexFile )



