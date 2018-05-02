function success = testExtractMusInfo(  )
success = 0;
musFileFolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\musfiles1';
Muses = extractMusInforFromFolder( musFileFolder )

assert(length(Muses) == 2);
%Muses(2).nodes{2}
assert( strcmp(Muses(2).nodes{2},'96_OGA1258') == 1);

success = true;





end

