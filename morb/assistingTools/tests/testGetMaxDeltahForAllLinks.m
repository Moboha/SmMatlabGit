basefolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up';
savefolder =    [basefolder, '\morb\assistingTools\tests\testData\']; 

prfAsCsv =[basefolder, '\frri\testData\fullPrfResults.csv'];%stair case training data


getMaxDeltahForAllLinks(prfAsCsv, savefolder)
